package gcu.backend.likeservice.controller;

import java.util.List;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import gcu.backend.likeservice.model.Like;
import gcu.backend.likeservice.repository.LikeRepository;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.web.bind.annotation.RequestBody;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.*;

import org.springframework.http.HttpStatus;

@RestController
@Tag(name = "Like", description = "즐겨찾기 API")
public class LikeController {

    @Autowired
    private LikeRepository likeRepository;

    @PostMapping("/like")
    @Operation(summary = "즐겨찾기", description = "즐겨찾기 테스트.")
    public ResponseEntity<Like> postLike(@Valid @RequestBody Like like) {
        System.out.print(like.toString());
        Like savedLike = likeRepository.save(like);
        return ResponseEntity.ok(savedLike);

    }

    @DeleteMapping("/like/{number}")
    @Operation(summary = "특정 즐겨찾기 정보 삭제", description = "즐겨찾기 삭제합니다.")
    public ResponseEntity<Like> deleteReservation(@PathVariable String number, String id) {

        try {
            likeRepository.deleteById(new ObjectId(id));
            return ResponseEntity.ok().build();
        } catch (EmptyResultDataAccessException e) {
            // 예약 ID에 해당하는 예약이 없을 경우 예외 처리
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            // 그 외의 예외 발생 시 예외 처리
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}
