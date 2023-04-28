package gcu.backend.classroomservice.model;

import lombok.Data;
import lombok.NoArgsConstructor;

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
    private List<Map<String, Object>> 강의목록;

    @Transient // 데이터 베이스에 없는 필드는 @Transient 어노테이션을 붙여준다.
    private boolean usable;

    // @Transient를 사용할 때는 따로 Constructor를 만들어줘야함
    public ClassRoom(ObjectId _id, String 호, String 전공, int 층, int 수용인원, String 규모, List<Map<String, Object>> 강의목록) {
        this._id = _id;
        this.호 = 호;
        this.전공 = 전공;
        this.층 = 층;
        this.수용인원 = 수용인원;
        this.규모 = 규모;
        this.강의목록 = 강의목록;
    }

    // 변수 usable은 Null이기 때문에 getter를 직접 만들기
    public boolean getUsable() {
        return true;
    }

}
