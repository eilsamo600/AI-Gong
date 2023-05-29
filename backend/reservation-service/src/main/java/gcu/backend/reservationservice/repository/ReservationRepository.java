package gcu.backend.reservationservice.repository;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import java.util.List;
import java.util.Optional;

import gcu.backend.reservationservice.model.Reservation;

public interface ReservationRepository extends MongoRepository<Reservation, ObjectId> {

    @Query("{'email':?0}")
    List<Reservation> findByEmailList(String email);

    @Query("{'number': ?0, 'date': ?1}")
    List<Reservation> findByNumberAndDate(String number, String date);

    @Query("{'email':?0}")
    Reservation findByEmail(String email);

    Optional<Reservation> findById(ObjectId _id);

    @Query(value = "{'_id':?0, 'email':?1}", delete = true)
    void DeleteByIdAndEmail(ObjectId _id, String email);
}
