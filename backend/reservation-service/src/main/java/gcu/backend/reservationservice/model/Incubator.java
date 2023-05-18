package gcu.backend.reservationservice.model;

import lombok.Data;

import java.util.Map;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.mapping.Document;

@Data // 자동으로 Getter Setter tostring constructor 다 만들어줌
@Document(collection = "incubator") // Mongodb JPA 사용할 때 필요한 어노테이션, collection 이름을 incubator로
public class Incubator {

    @Id
    private ObjectId _id; // MongoDB에서 자동으로 생성되는 필드

    // MongoDB 필드랑 이름 같아야함
    private int 호;
    private int 회의실번호;

    @Transient // 데이터 베이스에 없는 필드는 @Transient 어노테이션을 붙여준다.
    private int usableLevel; // 1은 사용가능, 2는 곧 끝남, 3은 사용불가능

    @Transient
    private String serverTime;

    @Transient
    private Map<String, String> currentReservation;

    // @Transient를 사용할 때는 따로 Constructor를 만들어줘야함
    public Incubator(ObjectId _id, int 호, int 회의실번호) {
        this._id = _id;
        this.호 = 호;
        this.회의실번호 = 회의실번호;

        // 사용가능한지 확인
        // level 1 : 사용가능, level 2 : 곧 끝남, level 3 : 사용불가능, level 4 : 곧 수업이 시작함
        this.usableLevel = 1;

        // 서버 시간 고정
        // week = 1;
        // hour = 10;

    }

}
