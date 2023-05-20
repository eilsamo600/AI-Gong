package gcu.backend.authservice.global.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import gcu.backend.authservice.global.oauth2.handler.OAuth2LoginFailureHandler;
import gcu.backend.authservice.global.oauth2.handler.OAuth2LoginSuccessHandler;
import gcu.backend.authservice.global.oauth2.service.CustomOAuth2UserService;

/**
 * 인증은 CustomJsonUsernamePasswordAuthenticationFilter에서 authenticate()로 인증된 사용자로
 * 처리
 * JwtAuthenticationProcessingFilter는 AccessToken, RefreshToken 재발급
 */
@Configuration
@EnableWebSecurity()
@RequiredArgsConstructor
public class SecurityConfig {

        private final OAuth2LoginSuccessHandler oAuth2LoginSuccessHandler;
        private final OAuth2LoginFailureHandler oAuth2LoginFailureHandler;
        private final CustomOAuth2UserService customOAuth2UserService;

        @Bean
        public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
                http
                                .csrf().disable() // csrf 보안 사용 X
                                .headers().frameOptions().disable()
                                .and()
                                // == URL별 권한 관리 옵션 ==//
                                .authorizeHttpRequests((authz) -> authz.
                                // 아이콘, css, js 관련
                                // 기본 페이지, css, image, js 하위 폴더에 있는 자료들은 모두 접근 가능, h2-console에 접근 가능
                                                requestMatchers("/info")
                                                .permitAll()
                                                .anyRequest().authenticated() // 위의 경로 이외에는 모두 인증된 사용자만 접근 가능)
                                )
                                // == 소셜 로그인 설정 ==//
                                .oauth2Login()
                                .successHandler(oAuth2LoginSuccessHandler) // 동의하고 계속하기를 눌렀을 때 Handler 설정
                                .failureHandler(oAuth2LoginFailureHandler) // 소셜 로그인 실패 시 핸들러 설정
                                .userInfoEndpoint().userService(customOAuth2UserService);
                return http.build();
        }
}