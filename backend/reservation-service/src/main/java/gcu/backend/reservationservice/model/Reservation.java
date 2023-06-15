package gcu.backend.reservationservice.model;

import lombok.Data;
import lombok.Getter;
import lombok.AllArgsConstructor;
import lombok.Setter;

import javax.swing.text.html.HTMLDocument.HTMLReader.PreAction;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Data
@Document(collection = "reservation")
public class Reservation {
    @Id
    private ObjectId _id;

    private String email;
    private String number;
    private List<Integer> time;
    private String date;
    private int people;
    private int state;

    @Transient
    private String id;

    public Reservation(ObjectId _id, String email, String number, List<Integer> time, String date, int people,
            int state) {
        this._id = _id;
        this.email = email;
        this.number = number;
        this.time = time;
        this.date = date;
        this.people = people;
        this.state = state;
        if (_id != null) {
            id = _id.toString();
        }
    }
}
