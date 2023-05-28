package gcu.backend.classroomservice.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import gcu.backend.classroomservice.model.ClassRoom;

public interface ClassRoomRepository extends MongoRepository<ClassRoom, Long> {

    @Query("{ '호' : ?0 }")
    ClassRoom findBy호(String 호);

    List<ClassRoom> findBy호In(List<String> 호);
}
