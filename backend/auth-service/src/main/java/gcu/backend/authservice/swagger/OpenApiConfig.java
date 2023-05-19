package gcu.backend.authservice.swagger;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;

@Configuration
public class OpenApiConfig {
    @Bean
    public OpenAPI openAPI() {
        Info info = new Info().title("유저 인증 API Document").version("v1").description("유저 인증 API 명세서입니다.");

        SecurityScheme basicAuth = new SecurityScheme().type(SecurityScheme.Type.HTTP).scheme("basic");
        SecurityRequirement securityItem = new SecurityRequirement().addList("basicAuth");

        return new OpenAPI().components(new Components().addSecuritySchemes("basicAuth", basicAuth))
                .addSecurityItem(securityItem).info(info);
    }

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**").allowedOrigins("*").allowedMethods("*").allowedHeaders("*");
            }
        };
    }
}
