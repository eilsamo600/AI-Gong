package gcu.backend.classroomservice.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import gcu.backend.classroomservice.model.ClassRoom;

public interface ClassRoomRepository extends MongoRepository<ClassRoom, Long> {

    @Query("{ '호' : ?0 }")
    ClassRoom findBy호(String 호);
}
