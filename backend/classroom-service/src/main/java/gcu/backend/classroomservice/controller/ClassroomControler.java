package gcu.backend.classroomservice.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import gcu.backend.classroomservice.jwt.JwtService;
import gcu.backend.classroomservice.model.ClassRoom;
import gcu.backend.classroomservice.model.Like;
import gcu.backend.classroomservice.repository.ClassRoomRepository;
import gcu.backend.classroomservice.repository.LikeRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;

// "ClassroomControler", RestController Class,
// used to handle requests from client
@RestController
@Tag(name = "Classroom", description = "강의실 API")
@Slf4j
public class ClassroomControler {

    // Field 'classRoomRepository', type 'ClassRoomRepository'
    // This value is used to query the database
    @Autowired
    private ClassRoomRepository classRoomRepository;

    // Field 'likeRepository', type 'LikeRepository'
    // This value is used to query the database
    @Autowired
    private LikeRepository likeRepository;

    // Field 'jwtService', type 'JwtService'
    // This value is used to generate and verify JWT
    @Autowired
    private JwtService jwtService;

    /*
     * GetMapping("/test") -> ResponseEntity<String> show()
     * This method is used to test if the server is running
     * 
     * Args:
     * - None
     * 
     * Return:
     * - ResponseEntity<String>: "hello Gachon University!"
     */
    @GetMapping("/test")
    @Operation(summary = "테스트", description = "테스트")
    public ResponseEntity<String> show() {
        return ResponseEntity.ok("hello Gachon University!");
    }

    /*
     * GetMapping("/classrooms") -> ResponseEntity<List<ClassRoom>>
     * This method is used to get all classrooms
     * 
     * Args:
     * - None
     * 
     * Return:
     * - ResponseEntity<List<ClassRoom>>: all classrooms
     */
    @GetMapping("/classrooms")
    @Operation(summary = "모든 강의실 목록 조회", description = "모든 강의실 목록을 조회합니다.")
    public ResponseEntity<List<ClassRoom>> getClassRoomList() {
        List<ClassRoom> classRoomList = classRoomRepository.findAll();
        for (ClassRoom classRoom : classRoomList) { // 강의목록 삭제해서 보냄
            classRoom.set강의목록(null);
        }
        return new ResponseEntity<List<ClassRoom>>(classRoomList, HttpStatus.OK);
    }

    /*
     * GetMapping("/classrooms/like") -> ResponseEntity<ClassRoom>
     * This method is used to get all classrooms that a user likes
     * 
     * Args:
     * - String value: Authorization header(containing email)
     * 
     * Return:
     * - ResponseEntity<List<ClassRoom>>: all classrooms that a user likes
     * 
     * Exceptions:
     * - HttpStatus.UNAUTHORIZED: if the email is not present in the token
     */
    @GetMapping("/classrooms/like")
    @Operation(summary = "즐겨찾기 강의실 목록 조회", description = "즐겨찾기 강의실 목록을 조회합니다.")
    public ResponseEntity<List<ClassRoom>> getClassRoomListByLike(@RequestHeader("Authorization") String value) {
        Optional<String> email = jwtService.extractAccessTokenInString(value)
                .map(token -> jwtService.extractEmail(token)).orElse(Optional.empty());
        if (!email.isPresent()) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }

        List<Like> likeList = likeRepository.findByEmail(email.get());
        List<String> 호List = likeList.stream().map(like -> like.get호()).toList();

        List<ClassRoom> classRoomList = classRoomRepository.findBy호In(호List);

        for (ClassRoom classRoom : classRoomList) { // 강의목록 삭제해서 보냄
            classRoom.set강의목록(null);
        }
        return new ResponseEntity<List<ClassRoom>>(classRoomList, HttpStatus.OK);
    }

    /*
     * GetMapping("/classroom/{id}") -> ResponseEntity<ClassRoom>
     * This method is used to get a specific classroom
     * 
     * Args:
     * - String value: Authorization header(containing email)
     * - String id: classroom id
     * 
     * Return:
     * - ResponseEntity<ClassRoom>: a specific classroom
     * 
     * Exceptions:
     * - HttpStatus.NOT_FOUND: if the classroom is not found
     */
    @GetMapping("/classroom/{id}")
    @Operation(summary = "특정 강의실 조회", description = "특정 강의실을 조회합니다.")
    public ResponseEntity<ClassRoom> getClassRoom(@RequestHeader("Authorization") String value,
            @PathVariable String id) {
        ClassRoom classRoom = classRoomRepository.findBy호(id);
        if (classRoom == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        Optional<String> email = jwtService.extractAccessTokenInString(value)
                .map(token -> jwtService.extractEmail(token)).orElse(Optional.empty());
        if (email.isPresent()) {
            Like like = likeRepository.findBy호AndEmail(id, email.get());
            if (like != null) {
                classRoom.setIsLike(true);
            } else {
                classRoom.setIsLike(false);
            }
        }

        return new ResponseEntity<ClassRoom>(classRoom, HttpStatus.OK);
    }

    /*
     * PostMapping("/classroom/{id}/like") -> ResponseEntity<ClassRoom>
     * This method is used to like a specific classroom
     * if the classroom is already liked, it will be unliked
     * 
     * Args:
     * - String value: Authorization header(containing email)
     * - String id: classroom id
     * 
     * Return:
     * - ResponseEntity<ClassRoom>: a specific classroom
     * 
     * Exceptions:
     * - HttpStatus.UNAUTHORIZED: if the email is not present in the token
     * - HttpStatus.NOT_FOUND: if the classroom is not found
     */
    @PostMapping("/classroom/{id}/like")
    @Operation(summary = "특정 강의실 즐겨찾기", description = "특정 강의실을 즐겨찾기한다.")
    public ResponseEntity<ClassRoom> postLikeClassRoom(@RequestHeader("Authorization") String value,
            @PathVariable String id) {

        Optional<String> email = jwtService.extractAccessTokenInString(value)
                .map(token -> jwtService.extractEmail(token)).orElse(Optional.empty());
        if (!email.isPresent()) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        ClassRoom classRoom = classRoomRepository.findBy호(id);
        if (classRoom == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        Like like = likeRepository.findBy호AndEmail(id, email.get());

        if (like == null) {
            like = new Like();
            like.setEmail(email.get());
            like.set호(id);
            likeRepository.save(like);
            classRoom.setIsLike(true);
        } else {
            likeRepository.delete(like);
            classRoom.setIsLike(false);
        }

        return new ResponseEntity<ClassRoom>(classRoom, HttpStatus.OK);
    }
}
