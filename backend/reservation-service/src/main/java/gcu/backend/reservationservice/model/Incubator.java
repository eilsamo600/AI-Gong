package gcu.backend.reservationservice.model;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.mapping.Document;

import gcu.backend.reservationservice.service.ReservationService;

@Data // 자동으로 Getter Setter tostring constructor 다 만들어줌
@Document(collection = "incubator") // Mongodb JPA 사용할 때 필요한 어노테이션, collection 이름을 incubator로
public class Incubator {

    @Id
    private ObjectId _id; // MongoDB에서 자동으로 생성되는 필드

    // MongoDB 필드랑 이름 같아야함
    private int 층;
    private String 호;
    private String 수용인원;
    private int 번호;

    @Transient // 데이터 베이스에 없는 필드는 @Transient 어노테이션을 붙여준다.
    private int usableLevel; // 1은 사용가능, 2는 곧 끝남, 3은 사용불가능

    // @Transient를 사용할 때는 따로 Constructor를 만들어줘야함
    public Incubator(ObjectId _id, int 층, String 호, String 수용인원, int 번호) {
        this._id = _id;
        this.층 = 층;
        this.호 = 호;
        this.수용인원 = 수용인원;
        this.번호 = 번호;

    }

}
