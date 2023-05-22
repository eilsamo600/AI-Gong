package gcu.backend.likeservice.model;

import lombok.Data;
import lombok.Getter;
import lombok.AllArgsConstructor;
import lombok.Setter;

import javax.swing.text.html.HTMLDocument.HTMLReader.PreAction;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Data
@Document(collection = "like")
public class Like {
    @Id
    private ObjectId _id;

    private String email;
    private String number;
    private List<Integer> time;
    private String date;
    private int people;
}
