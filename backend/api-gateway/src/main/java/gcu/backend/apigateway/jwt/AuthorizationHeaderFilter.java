package gcu.backend.apigateway.jwt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;

import gcu.backend.apigateway.domain.User;
import gcu.backend.apigateway.domain.repository.UserRepository;
import gcu.backend.apigateway.jwt.service.JwtService;
import jakarta.ws.rs.core.HttpHeaders;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import reactor.core.publisher.Mono;

@Slf4j
@Component
public class AuthorizationHeaderFilter extends AbstractGatewayFilterFactory<AuthorizationHeaderFilter.Config> {
    private final JwtService jwtService;
    private final UserRepository userRepository;

    public AuthorizationHeaderFilter(JwtService jwtService, UserRepository userRepository) {
        super(Config.class);
        this.jwtService = jwtService;
        this.userRepository = userRepository;
    }

    @Override
    public GatewayFilter apply(AuthorizationHeaderFilter.Config config) {
        return (exchange, chain) -> {
            ServerHttpRequest request = exchange.getRequest();
            ServerHttpResponse response = exchange.getResponse();

            String refreshToken = jwtService.extractRefreshToken(request)
                    .filter(jwtService::isTokenValid)
                    .orElse(null);
            log.info(refreshToken);

            if (refreshToken != null) {
                User user = userRepository.findByRefreshToken(refreshToken)
                        .orElse(null);

                if (user == null)
                    return onError(exchange, "refreshToken : Not found User Data", HttpStatus.NOT_FOUND);

                jwtService.sendAccessAndRefreshToken(response, jwtService.createAccessToken(user.getEmail()),
                        reIssueRefreshToken(user));
            }

            if (refreshToken == null) {
                String accessToken = jwtService.extractAccessToken(request)
                        .filter(jwtService::isTokenValid)
                        .orElse("");

                if (accessToken.isEmpty())
                    return onError(exchange, "Response Unauthorized", HttpStatus.UNAUTHORIZED);
            }
            return chain.filter(exchange);
        };
    }

    private String reIssueRefreshToken(User user) {
        String reIssuedRefreshToken = jwtService.createRefreshToken();
        user.updateRefreshToken(reIssuedRefreshToken);
        userRepository.save(user);
        return reIssuedRefreshToken;
    }

    private Mono<Void> onError(ServerWebExchange exchange, String err, HttpStatus httpStatus) {
        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(httpStatus);
        response.getHeaders().add(HttpHeaders.CONTENT_TYPE, "application/json");
        log.info(err);
        return response.setComplete();
    }

    public static class Config {

    }
}
