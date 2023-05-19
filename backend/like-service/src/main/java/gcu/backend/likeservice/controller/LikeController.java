package gcu.backend.likeservice.controller;

import java.util.List;
import org.springframework.boot.SpringApplication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
// import io.swagger.v3.oas.annotations.parameters.RequestBody;
import org.springframework.web.bind.annotation.RequestBody;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.ws.rs.core.Response;
import gcu.backend.likeservice.model.Like;
import gcu.backend.likeservice.repository.LikeRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import org.springframework.http.HttpStatus;

@RestController
@Tag(name = "Like", description = "즐겨찾기 API")
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

    // @GetMapping("/likes")
    // @Operation(summary = "모든 예약 테이블 조회", description = "예약 테이블 정보입니다.")
    // public ResponseEntity<List<Reservation>> getReservations() {
    // List<Reservation> reservations = reservationRepository.findAll();
    // return new ResponseEntity<List<Reservation>>(reservations, HttpStatus.OK);
    // }

    // @DeleteMapping("/like/{id}")
    // @Operation(summary = "특정 예약정보 삭제", description = "특정 예약정보를 삭제합니다.")
    // public ResponseEntity<Reservation> deleteReservation(@PathVariable String id)
    // {
    // Reservation reservation = reservationRepository.findByEmail(id);

    // if (reservation == null) {
    // return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    // }
    // reservationRepository.delete(reservation);

    // return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    // }

}
