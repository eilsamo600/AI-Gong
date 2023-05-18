
package gcu.backend.reservationservice.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import gcu.backend.reservationservice.model.Incubator;

public interface IncubatorRepository extends MongoRepository<Incubator, Long> {
    @Query("{ '호' : ?0 }")
    Incubator findBy호(String 호);
}
