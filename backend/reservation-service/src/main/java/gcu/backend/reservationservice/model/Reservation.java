package gcu.backend.reservationservice.model;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Data
@Document(collection = "reservation")
public class Reservation {
    @Id
    private Object _id;

    private String email;
    private String number;
    private List<Integer> time;
    private String date;
    private int people;

}
