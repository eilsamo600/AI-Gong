package gcu.backend.likeservice.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import gcu.backend.likeservice.model.Like;
import gcu.backend.likeservice.repository.LikeRepository;
import io.swagger.v3.oas.annotations.Operation;
// import io.swagger.v3.oas.annotations.parameters.RequestBody;
import org.springframework.web.bind.annotation.RequestBody;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.*;

import org.springframework.http.HttpStatus;

@RestController
@Tag(name = "Like", description = "예약 API")
public class LikeController {

    @Autowired
    private LikeRepository likeRepository;

    @PostMapping("/like")
    @Operation(summary = "예약 내역 보내기", description = "예약 내역 보내요~.")
    public ResponseEntity<Like> postLike(@Valid @RequestBody Like like) {
        System.out.print(like.toString());
        Like savedLike = likeRepository.save(like);
        return ResponseEntity.ok(savedLike);

    }

    @GetMapping("/like/{email}")
    @Operation(summary = "사용자 예약 테이블 조회", description = "예약 테이블 정보입니다.")
    public ResponseEntity<List<Like>> getLikes(@PathVariable String email) {
        List<Like> likes = likeRepository.findByEmailList(email);
        return new ResponseEntity<List<Like>>(likes, HttpStatus.OK);
    }

    // @GetMapping("/reservation/reservation/{number}")
    // @Operation(summary = "예약 정보 조회", description = "예약정보입니다")
    // public ResponseEntity<List<Like>> getavailable(@PathVariable String number,
    // String date) {
    // List<Like> reservation = reservationRepository.findByEmailAndDate(number,
    // date);
    // if (reservation == null) {
    // return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    // }
    // return new ResponseEntity<List<Like>>(reservation, HttpStatus.OK);
    // }

    // @DeleteMapping("/reservation/{id}")
    // @Operation(summary = "특정 예약정보 삭제", description = "특정 예약정보를 삭제합니다.")
    // public ResponseEntity<Like> deleteReservation(@PathVariable String id) {
    // Like reservation = reservationRepository.findByEmail(id);

    // if (reservation == null) {
    // return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    // }
    // reservationRepository.delete(reservation);

    // return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    // }

}
