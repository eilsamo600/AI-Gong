package gcu.backend.classroomservice.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import gcu.backend.classroomservice.model.Like;

public interface LikeRepository extends MongoRepository<Like, Long> {

    @Query("{ '호' : ?0 }")
    Like findBy호(String 호);

    @Query("{ '호' : ?0, 'email' : ?1 }")
    Like findBy호AndEmail(String 호, String email);

    @Query("{ 'email' : ?0 }")
    List<Like> findByEmail(String email);
}
