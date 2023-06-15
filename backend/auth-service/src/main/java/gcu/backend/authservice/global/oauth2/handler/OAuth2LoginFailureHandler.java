package gcu.backend.authservice.global.oauth2.handler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// "OAuth2LoginFailureHandler" is a class that implements "AuthenticationFailureHandler" interface.
// It is used to handle OAuth2 login failure.
@Slf4j
@Component("oauth2LoginFailureHandler")
public class OAuth2LoginFailureHandler implements AuthenticationFailureHandler {
    /*
     * onAuthenticationFailure(), this method is called when OAuth2 login fails.
     * 
     * Args:
     * - request: HttpServletRequest : HttpServletRequest object
     * - response: HttpServletResponse : HttpServletResponse object
     * 
     * Return:
     * - void
     */
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("소셜 로그인 실패! 서버 로그를 확인해주세요.");
        log.info("소셜 로그인에 실패했습니다. 에러 메시지 : {}", exception.getMessage());
    }
}