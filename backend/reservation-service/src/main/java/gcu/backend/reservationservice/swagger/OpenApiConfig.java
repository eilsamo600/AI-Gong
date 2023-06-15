package gcu.backend.reservationservice.swagger;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

// "OpenApiConfig", Configuration Class,
// used to configure Swagger
@Configuration
public class OpenApiConfig {

    /*
     * OpenAPI openAPI()
     * This method is used to configure Swagger
     * 
     * Return:
     * - OpenAPI: the OpenAPI object
     */
    @Bean
    public OpenAPI openAPI() {
        Info info = new Info().title("예약 API Document").version("v1").description("예약 API 명세서입니다.");
        return new OpenAPI().components(new Components()).info(info);
    }

    /*
     * WebMvcConfigurer corsConfigurer()
     * This method is used to configure CORS
     * 
     * Return:
     * - WebMvcConfigurer: the WebMvcConfigurer object
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
