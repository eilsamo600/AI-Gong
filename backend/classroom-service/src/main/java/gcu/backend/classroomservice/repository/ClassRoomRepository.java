package gcu.backend.classroomservice.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import gcu.backend.classroomservice.model.ClassRoom;

public interface ClassRoomRepository extends MongoRepository<ClassRoom, Long> {

}
