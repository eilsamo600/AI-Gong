package gcu.backend.apigateway.swagger;

import org.springdoc.core.properties.SwaggerUiConfigParameters;
import org.springframework.boot.CommandLineRunner;
import org.springframework.cloud.gateway.route.RouteDefinition;
import org.springframework.cloud.gateway.route.RouteDefinitionLocator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@Configuration
public class OpenApiConfig {
    // @Bean
    // public CommandLineRunner openApiGroups(
    // RouteDefinitionLocator locator,
    // SwaggerUiConfigParameters swaggerUiParameters) {
    // return args ->
    // locator.getRouteDefinitions().collectList().block().stream().map(RouteDefinition::getId)
    // .filter(id -> id.matches(".*-service")).map(id -> id.replace("-service", ""))
    // .forEach(swaggerUiParameters::addGroup);

    // }

    @Bean
    public OpenAPI openAPI() {
        Info info = new Info().title("강의실 API Document").version("v1").description("강의실 API 명세서입니다.");
        return new OpenAPI().components(new Components()).info(info);
    }
}
