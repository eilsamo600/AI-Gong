package gcu.backend.apigateway.jwt;

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
@RequiredArgsConstructor
public class AuthorizationHeaderFilter extends AbstractGatewayFilterFactory<AuthorizationHeaderFilter.Config> {
    private final Environment environment;
    private final JwtService jwtService;
    private final UserRepository userRepository;

    @Override
    public GatewayFilter apply(AuthorizationHeaderFilter.Config config) {
        return (exchange, chain) -> {
            ServerHttpRequest request = exchange.getRequest();
            ServerHttpResponse response = exchange.getResponse();

            String refreshToken = jwtService.extractRefreshToken(request)
                    .filter(jwtService::isTokenValid)
                    .orElse(null);

            if (refreshToken != null) {
                String reIssuedRefreshToken = "";
                userRepository.findByRefreshToken(refreshToken)
                        .ifPresent(user -> {
                            reIssuedRefreshToken = reIssueRefreshToken(user);
                            jwtService.sendAccessAndRefreshToken(response,
                                    jwtService.createAccessToken(user.getEmail()),
                                    reIssuedRefreshToken);

                        });
                if (reIssuedRefreshToken.isEmpty())
                    return onError(exchange, "refreshToken Refresh : Not found User Data", HttpStatus.NOT_FOUND);

                return chain.filter(exchange);
            }

            if (refreshToken == null) {
                checkAccessTokenAndAuthentication(request, response, filterChain);
            }
            // if (!request.getHeaders().containsKey(HttpHeaders.AUTHORIZATION))
            // return onError(exchange, "No authorization header", HttpStatus.UNAUTHORIZED);
            // String authorizationHeader =
            // request.getHeaders().get(HttpHeaders.AUTHORIZATION).get(0);
            // String jwt = authorizationHeader.replace("Bearer", "");
            // // if (!isJwtValid(jwt))
            // // return onError(exchange, "JWT token is not valid",
            // HttpStatus.UNAUTHORIZED);
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
        log.error(err);
        return response.setComplete();
    }

    public static class Config {
    }
}