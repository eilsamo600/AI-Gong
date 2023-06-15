package gcu.backend.classroomservice.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import gcu.backend.classroomservice.model.ClassRoom;

// "ClassRoomRepository", JPA Interface, used to query the database, MongoRepository
public interface ClassRoomRepository extends MongoRepository<ClassRoom, Long> {

    // Query methods, find by 호
    @Query("{ '호' : ?0 }")
    ClassRoom findBy호(String 호);

    // Query methods, find by 호 and email
    List<ClassRoom> findBy호In(List<String> 호);
}
