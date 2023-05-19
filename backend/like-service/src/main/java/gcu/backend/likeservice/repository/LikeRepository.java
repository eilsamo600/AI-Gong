package gcu.backend.likeservice.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import gcu.backend.likeservice.model.Like;

public interface LikeRepository extends MongoRepository<Like, Long> {

    @Query("{'email':?0}")
    Like findByEmail(String email);
}
