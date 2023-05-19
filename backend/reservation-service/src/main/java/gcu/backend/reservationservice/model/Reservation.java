package gcu.backend.reservationservice.model;

import lombok.Data;
import lombok.Getter;
import lombok.AllArgsConstructor;
import lombok.Setter;

import javax.swing.text.html.HTMLDocument.HTMLReader.PreAction;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;
import java.util.ArrayList;

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

}
