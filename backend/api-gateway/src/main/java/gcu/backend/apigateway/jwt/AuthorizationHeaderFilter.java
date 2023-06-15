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

// "AuthorizationHeaderFilter", used to filter the authorization header
// used to check if the user is logged in
// used to check if the user is authorized to access the service

@Slf4j
@Component
public class AuthorizationHeaderFilter extends AbstractGatewayFilterFactory<AuthorizationHeaderFilter.Config> {
    private final JwtService jwtService;
    private final UserRepository userRepository;

    /*
     * AuthorizationHeaderFilter(Config config) -> AuthorizationHeaderFilter
     * This constructor is used to initialize the JwtService and UserRepository
     * 
     * Args:
     * - JwtService jwtService: used to generate and verify JWT
     * - UserRepository userRepository: used to query the database
     * 
     * Return:
     * - AuthorizationHeaderFilter: the AuthorizationHeaderFilter object
     */
    public AuthorizationHeaderFilter(JwtService jwtService, UserRepository userRepository) {
        super(Config.class);
        this.jwtService = jwtService;
        this.userRepository = userRepository;
    }

    /*
     * apply(Config config) -> GatewayFilter
     * This method is used to filter the authorization header
     * 
     * Args:
     * - Config config: the configuration of the filter
     * 
     * Return:
     * - GatewayFilter: the GatewayFilter object
     */
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

    /*
     * reIssueRefreshToken(User user) -> String
     * This method is used to re-issue the refresh token
     * 
     * Args:
     * - User user: the user object
     * 
     * Return:
     * - String: the re-issued refresh token
     */
    private String reIssueRefreshToken(User user) {
        String reIssuedRefreshToken = jwtService.createRefreshToken();
        user.updateRefreshToken(reIssuedRefreshToken);
        userRepository.save(user);
        return reIssuedRefreshToken;
    }

    /*
     * onError(ServerWebExchange exchange, String err, HttpStatus httpStatus) ->
     * Mono<Void> This method is used to handle the error
     * 
     * Args:
     * - ServerWebExchange exchange: the server web exchange object
     * - String err: the error message
     * - HttpStatus httpStatus: the http status
     * 
     * Return:
     * - Mono<Void>: the Mono<Void> object
     */
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
