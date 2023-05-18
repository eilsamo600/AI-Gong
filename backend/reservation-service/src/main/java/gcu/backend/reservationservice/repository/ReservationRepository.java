package gcu.backend.reservationservice.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import gcu.backend.reservationservice.model.Reservation;

public interface ReservationRepository extends MongoRepository<Reservation, Object> {

    @Query("{'email':?0}")
    Reservation findByEmail(String email);
}
