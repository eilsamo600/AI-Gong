package gcu.backend.authservice.domain.user.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import gcu.backend.authservice.domain.user.User;
import gcu.backend.authservice.domain.user.repository.UserRepository;
import gcu.backend.authservice.global.jwt.service.JwtService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Tag(name = "User", description = "인증&유저 API")
@Slf4j
public class UserController {
    private final JwtService jwtService;
    private final UserRepository userRepository;

    @GetMapping("/info")
    @Operation(summary = "Get User Info", description = "Access 토큰을 이용해서 유저 정보를 가져옵니다.")
    public ResponseEntity<User> getInfo(@RequestHeader("Authorization") String value) {

        Optional<String> email = jwtService.extractAccessTokenInString(value)
                .map(token -> jwtService.extractEmail(token)).orElse(null);
        log.info("email: " + email);
        if (!email.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        Optional<User> user = userRepository.findByEmail(email.get());
        log.info("user: " + user);
        if (!user.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(user.get());
    }

    @GetMapping("/test")
    public String testest() {
        return "Test 요청 성공";
    }
}
