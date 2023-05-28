package gcu.backend.classroomservice.model;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Builder;
import lombok.Data;

@Data
@Document(collection = "like")
public class Like {
    @Id
    private ObjectId _id; // MongoDB에서 자동으로 생성되는 필드

    private String email;
    private String 호;
}
