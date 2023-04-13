package gcu.backend.classroomservice.swagger;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@Configuration
public class OpenApiConfig {
    @Bean
    public OpenAPI openAPI() {
        Info info = new Info().title("강의실 API Document").version("v1").description("강의실 API 명세서입니다.");
        return new OpenAPI().components(new Components()).info(info);
    }
}
