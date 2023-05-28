package gcu.backend.likeservice.repository;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import gcu.backend.likeservice.model.Like;

import java.util.List;

public interface LikeRepository extends MongoRepository<Like, ObjectId> {

    @Query("{'email':?0}")
    List<Like> findByEmailList(String email);

    @Query("{'number': ?0, 'date': ?1}")
    List<Like> findByEmailAndDate(String number, String date);

    @Query("{'email':?0}")
    Like findByEmail(String email);

}
