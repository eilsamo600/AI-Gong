package gcu.backend.likeservice.controller;

import java.util.List;
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
@Tag(name = "Like", description = "즐겨찾기")
public class LikeController {

    @Autowired
    private LikeRepository likeRepository;

    @PostMapping("/like")
    @Operation(summary = "즐겨찾기 내역 보내기", description = "즐겨찾기 내역 보내요~.")
    public ResponseEntity<Like> postLike(@Valid @RequestBody Like like) {
        System.out.print(like.toString());
        Like savedLike = likeRepository.save(like);
        return ResponseEntity.ok(savedLike);

    }

    @GetMapping("/likes")
    @Operation(summary = "모든 즐겨찾기 테이블 조회", description = "즐겨찾기 테이블 정보입니다.")
    public ResponseEntity<List<Like>> getLikes() {
        List<Like> likes = likeRepository.findAll();
        return new ResponseEntity<List<Like>>(likes, HttpStatus.OK);
    }

    @DeleteMapping("/like/{id}")
    @Operation(summary = "특정 즐겨찾기 삭제", description = "특정 즐겨찾기를 삭제합니다.")
    public ResponseEntity<Like> deleteLike(@PathVariable Long id) {
        likeRepository.deleteById(id);
        // if (reservation == null) {
        // return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        // }
        return new ResponseEntity<Like>(HttpStatus.OK);
    }

}
