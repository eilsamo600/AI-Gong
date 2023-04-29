package gcu.backend.classroomservice.model;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;
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
    private boolean usable;

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

        this.usable = true;
        LocalTime now = LocalTime.now();
        LocalDate today = LocalDate.now();
        int week = today.getDayOfWeek().getValue();
        week = 1;
        float time = (now.getHour() + 1) * 60 + (now.getMinute() + 1);

        List<Map<String, Object>> lectureList = this.강의목록.get(Integer.toString(week));
        if (lectureList == null) {
            this.usable = true;
            return;
        }
        for (Map<String, Object> lectureInfo : lectureList) {
            float start = ((float) lectureInfo.get("시작시간") + 8) * 60;
            float end = (float) lectureInfo.get("종료시간");
            // 현재 시간에 맞는 강의가 있으면 usable을 false로 설정
            if (time >= start && time <= start + end) {
                this.usable = false;
                break;
            }
        }
    }

}
