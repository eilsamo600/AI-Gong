package gcu.backend.authservice.domain.user.repository;

import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;

import gcu.backend.authservice.domain.user.SocialType;
import gcu.backend.authservice.domain.user.User;

// "UserRepository", used to specify the user repository, MongoRepository
public interface UserRepository extends MongoRepository<User, Long> {

    // Query methods, find by email
    Optional<User> findByEmail(String email);

    // Query methods, find by nickname
    Optional<User> findByNickname(String nickname);

    // Query methods, find by refresh token
    Optional<User> findByRefreshToken(String refreshToken);

    /**
     * 소셜 타입과 소셜의 식별값으로 회원 찾는 메소드
     * 정보 제공을 동의한 순간 DB에 저장해야하지만, 아직 추가 정보(사는 도시, 나이 등)를 입력받지 않았으므로
     * 유저 객체는 DB에 있지만, 추가 정보가 빠진 상태이다.
     * 따라서 추가 정보를 입력받아 회원 가입을 진행할 때 소셜 타입, 식별자로 해당 회원을 찾기 위한 메소드
     */
    Optional<User> findBySocialTypeAndSocialId(SocialType socialType, String socialId);
}
