package gcu.backend.reservationservice.repository;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import java.util.List;
import java.util.Optional;

import gcu.backend.reservationservice.model.Reservation;

// "ReservationRepository", used to specify the reservation repository, MongoRepository
public interface ReservationRepository extends MongoRepository<Reservation, ObjectId> {

    // Method 'findByNumber', used to find the reservation by number
    @Query("{'email':?0}")
    List<Reservation> findByEmailList(String email);

    // Method 'findByNumber', used to find the reservation by number
    @Query("{'number':?0, 'date':?1}")
    List<Reservation> findByNumberAndDate(String number, String date);

    // Method 'findByNumber', used to find the reservation by number
    @Query("{'email':?0}")
    Reservation findByEmail(String email);

    // Method 'findById', used to find the reservation by id
    Optional<Reservation> findById(ObjectId _id);

    // Method 'DeleteByIdAndEmail', used to delete the reservation by id and email
    @Query(value = "{'_id':?0, 'email':?1}", delete = true)
    void DeleteByIdAndEmail(ObjectId _id, String email);
}
