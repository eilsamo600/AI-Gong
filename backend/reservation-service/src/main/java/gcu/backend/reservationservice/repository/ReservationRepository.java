package gcu.backend.reservationservice.repository;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import java.util.List;

import gcu.backend.reservationservice.model.Reservation;

public interface ReservationRepository extends MongoRepository<Reservation, ObjectId> {

    @Query("{'email':?0}")
    List<Reservation> findByEmailList(String email);

    @Query("{'number': ?0, 'date': ?1}")
    List<Reservation> findByEmailAndDate(String number, String date);

    @Query("{'email':?0}")
    Reservation findByEmail(String email);

}
