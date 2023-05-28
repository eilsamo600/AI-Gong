package gcu.backend.classroomservice.model;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.mapping.Document;

@Data // 자동으로 Getter Setter tostring constructor 다 만들어줌
@Document(collection = "classroom") // Mongodb JPA 사용할 때 필요한 어노테이션, collection 이름을 classroom으로
public class ClassRoom {

    @Id
    private ObjectId _id; // MongoDB에서 자동으로 생성되는 필드

    // MongoDB 필드랑 이름 같아야함
    private String 호;
    private String 전공;
    private int 층;
    private int 수용인원;
    private String 규모;
    // 강의목록 : { 날짜 : [강의1, 강의2, ...]}
    // 강의 : { 교과목명: '', 담당교수: '', 강의실: '', 정원: '', 개설조직: '', 시작시간: '', 수업시간: ''}
    private Map<String, List<Map<String, Object>>> 강의목록;

    @Transient // 데이터 베이스에 없는 필드는 @Transient 어노테이션을 붙여준다.
    private int usableLevel; // 1은 사용가능, 2는 곧 끝남, 3은 사용불가능

    @Transient
    private String serverTime;

    @Transient
    private Map<String, String> currentLecture;

    @Transient
    private Boolean isLike;

    // @Transient를 사용할 때는 따로 Constructor를 만들어줘야함
    public ClassRoom(ObjectId _id, String 호, String 전공, int 층, int 수용인원, String 규모,
            Map<String, List<Map<String, Object>>> 강의목록) {
        this._id = _id;
        this.호 = 호;
        this.전공 = 전공;
        this.층 = 층;
        this.수용인원 = 수용인원;
        this.규모 = 규모;
        this.강의목록 = 강의목록;

        // 사용가능한지 확인
        // level 1 : 사용가능, level 2 : 곧 끝남, level 3 : 사용불가능, level 4 : 곧 수업이 시작함
        this.usableLevel = 1;

        LocalTime now = LocalTime.now();
        LocalDate today = LocalDate.now();
        int week = today.getDayOfWeek().getValue();
        int hour = now.getHour();
        int minute = now.getMinute();
        // 서버 시간 고정
        // week = 1;
        // hour = 10;
        float time = hour * 60 + minute;
        this.serverTime = String.format("%d-%02d:%02d", week, hour, minute);

        List<Map<String, Object>> lectureList = this.강의목록.get(Integer.toString(week));
        if (lectureList == null) {
            return;
        }
        // DB에서 강의 목록은 시작 시간 순으로 이미 정렬되어 있음
        // 9시 수업부터 보면서 현재 시간에 맞는 강의가 있는지 확인
        for (Map<String, Object> lectureInfo : lectureList) {
            float start = (((Number) lectureInfo.get("시작시간")).floatValue() + 8) * 60;
            float duration = ((Number) lectureInfo.get("수업시간")).floatValue();
            // 현재 시간에 맞는 강의가 있으면 usable을 false로 설정
            if (time >= start && time <= start + duration) {
                this.currentLecture = new HashMap<String, String>();
                this.currentLecture.put("이름", (String) lectureInfo.get("교과목명"));
                this.currentLecture.put("담당교수", (String) lectureInfo.get("담당교수"));
                this.currentLecture.put("시간", String.format("%02d:%02d ~ %02d:%02d", (int) start / 60, (int) start % 60,
                        (int) (start + duration) / 60, (int) (start + duration) % 60));
                this.usableLevel = 3;
                if ((start + duration) - time < 15) {
                    this.usableLevel = 2;
                }
                break;
            }

            // 곧 시작할거같으면~~~
            if (time < start) {
                this.currentLecture = new HashMap<String, String>();
                this.currentLecture.put("이름", (String) lectureInfo.get("교과목명"));
                this.currentLecture.put("담당교수", (String) lectureInfo.get("담당교수"));
                this.currentLecture.put("시간", String.format("%02d:%02d ~ %02d:%02d", (int) start / 60, (int) start % 60,
                        (int) (start + duration) / 60, (int) (start + duration) % 60));

                if ((start - time) < 15) {
                    this.usableLevel = 4;
                }
                break;
            }
        }
    }

}
