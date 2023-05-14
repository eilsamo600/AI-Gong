package gcu.backend.reservationservice.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import gcu.backend.reservationservice.model.Reservation;

public interface ReservationRepository extends MongoRepository<Reservation, Long> {

}
