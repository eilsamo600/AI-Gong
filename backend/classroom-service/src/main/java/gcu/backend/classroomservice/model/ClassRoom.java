package gcu.backend.classroomservice.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collection = "classroom")
public class ClassRoom {

    @Id
    private ObjectId _id;

    private String 호;
    private String 전공;
    private int 층;
    private int 수용인원;
    private String 규모;
    private List<Map<String, Object>> 강의목록;

    @Transient
    private boolean usable;

    public ClassRoom(ObjectId _id, String 호, String 전공, int 층, int 수용인원, String 규모, List<Map<String, Object>> 강의목록) {
        this._id = _id;
        this.호 = 호;
        this.전공 = 전공;
        this.층 = 층;
        this.수용인원 = 수용인원;
        this.규모 = 규모;
        this.강의목록 = 강의목록;
    }

    public boolean getUsable() {
        return true;
    }

}
