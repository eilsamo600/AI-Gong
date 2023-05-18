package gcu.backend.authservice.global.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.HttpStatusEntryPoint;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.context.DelegatingSecurityContextRepository;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.RequestAttributeSecurityContextRepository;

import gcu.backend.authservice.domain.user.repository.UserRepository;
import gcu.backend.authservice.global.jwt.filter.JwtAuthenticationProcessingFilter;
import gcu.backend.authservice.global.jwt.service.JwtService;
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

        private final JwtService jwtService;
        private final UserRepository userRepository;
        private final OAuth2LoginSuccessHandler oAuth2LoginSuccessHandler;
        private final OAuth2LoginFailureHandler oAuth2LoginFailureHandler;
        private final CustomOAuth2UserService customOAuth2UserService;

        @Bean
        public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
                http
                                .csrf().disable() // csrf 보안 사용 X
                                .headers().frameOptions().disable()
                                .and()
                                .securityContext((securityContext) -> {
                                        securityContext.securityContextRepository(
                                                        delegatingSecurityContextRepository());
                                        securityContext.requireExplicitSave(true);
                                })
                                // == URL별 권한 관리 옵션 ==//
                                .authorizeHttpRequests((authz) -> authz.
                                // 아이콘, css, js 관련
                                // 기본 페이지, css, image, js 하위 폴더에 있는 자료들은 모두 접근 가능, h2-console에 접근 가능
                                                requestMatchers("/index.html", "/css/**", "/images/**", "/js/**",
                                                                "/favicon.ico",
                                                                "/h2-console/**", "/sign-up", "/test", "/oauth2/**",
                                                                "/login/**", "/logout**", "/login**",
                                                                "/login/oauth2/code/google**",
                                                                "/login/oauth2/code/google",
                                                                "/login/oauth2/code/google/**")
                                                .permitAll()
                                                .anyRequest().authenticated() // 위의 경로 이외에는 모두 인증된 사용자만 접근 가능)
                                ).logout().logoutSuccessUrl("/").invalidateHttpSession(true).clearAuthentication(true)
                                .deleteCookies("JSESSIONID").and()
                                // == 소셜 로그인 설정 ==//
                                .oauth2Login()
                                .successHandler(oAuth2LoginSuccessHandler) // 동의하고 계속하기를 눌렀을 때 Handler 설정
                                .failureHandler(oAuth2LoginFailureHandler) // 소셜 로그인 실패 시 핸들러 설정
                                .userInfoEndpoint().userService(customOAuth2UserService);

                http.exceptionHandling()
                                .authenticationEntryPoint(new MyAuthenticationEntryPoint());
                // customUserService 설정

                // 원래 스프링 시큐리티 필터 순서가 LogoutFilter 이후에 로그인 필터 동작
                // 따라서, LogoutFilter 이후에 우리가 만든 필터 동작하도록 설정
                // 순서 : LogoutFilter -> JwtuthenticationProcessingFilter ->
                // CustomJsonUsernamePasswordAuthenticationFilter
                http.addFilterBefore(jwtAuthenticationProcessingFilter(), UsernamePasswordAuthenticationFilter.class);

                return http.build();
        }

        @Bean
        public DelegatingSecurityContextRepository delegatingSecurityContextRepository() {
                return new DelegatingSecurityContextRepository(
                                new RequestAttributeSecurityContextRepository());
        }

        @Bean
        public JwtAuthenticationProcessingFilter jwtAuthenticationProcessingFilter() {
                JwtAuthenticationProcessingFilter jwtAuthenticationFilter = new JwtAuthenticationProcessingFilter(
                                jwtService,
                                userRepository, delegatingSecurityContextRepository());
                return jwtAuthenticationFilter;
        }
}