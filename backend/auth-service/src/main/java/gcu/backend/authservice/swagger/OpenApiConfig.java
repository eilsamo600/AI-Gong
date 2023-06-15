package gcu.backend.authservice.swagger;

import java.util.Arrays;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;

// "OpenApiConfig", Configuration Class,
// used to configure Swagger
@Configuration
public class OpenApiConfig {

    /*
     * OpenAPI openAPI()
     * This method is used to configure Swagger
     * It sets the title, version, and description of the API
     * It also sets the security scheme to use JWT
     * 
     * Args:
     * - None
     * 
     * Return:
     * - OpenAPI: OpenAPI object
     */
    @Bean
    public OpenAPI openAPI() {
        Info info = new Info().title("유저 인증 API Document").version("v1").description("유저 인증 API 명세서입니다.");

        SecurityScheme basicAuth = new SecurityScheme().type(SecurityScheme.Type.HTTP).scheme("bearer")
                .bearerFormat("JWT").in(SecurityScheme.In.HEADER).name("Authorization");
        SecurityRequirement securityItem = new SecurityRequirement().addList("bearerAuth");

        return new OpenAPI().components(new Components().addSecuritySchemes("bearerAuth", basicAuth))
                .security(Arrays.asList(securityItem)).info(info);
    }

    /*
     * WebMvcConfigurer corsConfigurer()
     * This method is used to configure CORS
     * 
     * Args:
     * - None
     * 
     * Return:
     * - WebMvcConfigurer: WebMvcConfigurer object
     */
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
