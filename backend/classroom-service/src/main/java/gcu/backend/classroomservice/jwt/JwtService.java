package gcu.backend.classroomservice.jwt;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;

import jakarta.servlet.http.HttpServletRequest;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Optional;

// "JwtService", Service Class, used to generate and verify JWT
@Service
@RequiredArgsConstructor
@Getter
@Slf4j
public class JwtService {

    // Field 'secretKey', type 'String'
    // This value is used to generate JWT
    @Value("${jwt.secretKey}")
    private String secretKey;

    // Field 'accessTokenExpirationPeriod', type 'Long'
    // This value is used to set the expiration period of access token
    @Value("${jwt.access.expiration}")
    private Long accessTokenExpirationPeriod;

    // Field 'refreshTokenExpirationPeriod', type 'Long'
    // This value is used to set the expiration period of refresh token
    @Value("${jwt.refresh.expiration}")
    private Long refreshTokenExpirationPeriod;

    // Field 'accessHeader', type 'String'
    // This value is used to set the header of access token
    @Value("${jwt.access.header}")
    private String accessHeader;

    // Field 'refreshHeader', type 'String'
    // This value is used to set the header of refresh token
    @Value("${jwt.refresh.header}")
    private String refreshHeader;

    /**
     * JWT의 Subject와 Claim으로 email 사용 -> 클레임의 name을 "email"으로 설정
     * JWT의 헤더에 들어오는 값 : 'Authorization(Key) = Bearer {토큰} (Value)' 형식
     */
    private static final String EMAIL_CLAIM = "email";
    private static final String BEARER = "Bearer ";

    /*
     * Extract RefreshToken from HttpServletRequest
     * Args:
     * - HttpServletRequest request: request from client
     * 
     * Return:
     * - Optional<String>: RefreshToken
     */
    public Optional<String> extractAccessToken(HttpServletRequest request) {
        return Optional.ofNullable(request.getHeader(accessHeader))
                .filter(refreshToken -> refreshToken.startsWith(BEARER))
                .map(refreshToken -> refreshToken.replace(BEARER, ""));
    }

    /*
     * Extract RefreshToken from String pass as argument
     * Args:
     * - String refreshToken: RefreshToken
     * 
     * Return:
     * - Optional<String>: RefreshToken
     */
    public Optional<String> extractAccessTokenInString(String accessToken) {
        return Optional.ofNullable(accessToken)
                .filter(refreshToken -> refreshToken.startsWith(BEARER))
                .map(refreshToken -> refreshToken.replace(BEARER, ""));
    }

    /**
     * AccessToken에서 Email 추출
     * 추출 전에 JWT.require()로 검증기 생성
     * verify로 AceessToken 검증 후
     * 유효하다면 getClaim()으로 이메일 추출
     * 유효하지 않다면 빈 Optional 객체 반환
     */

    /*
     * Extract Email from AccessToken,
     * jwt verifier is created by JWT.require() before extracting
     * 
     * Args:
     * - String accessToken: AccessToken
     *
     * Return:
     * - Optional<String>: Email
     */
    public Optional<String> extractEmail(String accessToken) {
        try {
            // 토큰 유효성 검사하는 데에 사용할 알고리즘이 있는 JWT verifier builder 반환
            return Optional.ofNullable(JWT.require(Algorithm.HMAC512(secretKey))
                    .build() // 반환된 빌더로 JWT verifier 생성
                    .verify(accessToken) // accessToken을 검증하고 유효하지 않다면 예외 발생
                    .getClaim(EMAIL_CLAIM) // claim(Emial) 가져오기
                    .asString());
        } catch (Exception e) {
            log.error(accessToken);
            log.error(e.toString());
            log.error("Not Valid Access Token");

            return Optional.empty();
        }
    }

    /*
     * verify AccessToken
     * 
     * Args:
     * - String email: Email
     * 
     * Return:
     * - String: AccessToken
     */
    public boolean isTokenValid(String token) {
        try {
            JWT.require(Algorithm.HMAC512(secretKey)).build().verify(token);
            return true;
        } catch (Exception e) {
            log.error("유효하지 않은 토큰입니다. {}", e.getMessage());
            return false;
        }
    }
}