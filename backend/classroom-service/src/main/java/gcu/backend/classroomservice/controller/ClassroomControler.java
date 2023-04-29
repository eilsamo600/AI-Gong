package gcu.backend.classroomservice.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import gcu.backend.classroomservice.model.ClassRoom;
import gcu.backend.classroomservice.repository.ClassRoomRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@Tag(name = "Classroom", description = "강의실 API")
public class ClassroomControler {
    @Autowired
    private ClassRoomRepository classRoomRepository;

    @GetMapping("/test")
    @Operation(summary = "테스트", description = "테스트")
    public ResponseEntity<String> show() {
        return ResponseEntity.ok("hello Gachon University!");
    }

    @GetMapping("/test2")
    @Operation(summary = "뚝딱 만듬 ~", description = "멋진 api")
    public ResponseEntity<String> show2() {
        return ResponseEntity.ok("안녕하세요 ㅋㅋ");
    }

    @GetMapping("/classrooms")
    @Operation(summary = "모든 강의실 목록 조회", description = "모든 강의실 목록을 조회합니다.")
    public ResponseEntity<List<ClassRoom>> getClassRoomList() {
        List<ClassRoom> classRoomList = classRoomRepository.findAll();
        for (ClassRoom classRoom : classRoomList) { // 강의목록 삭제해서 보냄
            classRoom.set강의목록(null);
        }
        return new ResponseEntity<List<ClassRoom>>(classRoomList, HttpStatus.OK);
    }
}
