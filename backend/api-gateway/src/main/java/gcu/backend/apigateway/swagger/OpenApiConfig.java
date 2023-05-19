package gcu.backend.apigateway.swagger;

import org.springdoc.core.properties.SwaggerUiConfigParameters;
import org.springframework.boot.CommandLineRunner;
import org.springframework.cloud.gateway.route.RouteDefinition;
import org.springframework.cloud.gateway.route.RouteDefinitionLocator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {
    @Bean
    public CommandLineRunner openApiGroups(
            RouteDefinitionLocator locator,
            SwaggerUiConfigParameters swaggerUiParameters) {
        return args -> locator.getRouteDefinitions().collectList().block().stream().map(RouteDefinition::getId)
                .filter(id -> id.matches(".*-service")).map(id -> id.replace("-service", ""))
                .forEach(swaggerUiParameters::addGroup);

    }

}
