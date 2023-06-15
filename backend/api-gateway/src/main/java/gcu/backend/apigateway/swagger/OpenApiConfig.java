package gcu.backend.apigateway.swagger;

import org.springdoc.core.properties.SwaggerUiConfigParameters;
import org.springframework.boot.CommandLineRunner;
import org.springframework.cloud.gateway.route.RouteDefinition;
import org.springframework.cloud.gateway.route.RouteDefinitionLocator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

// "OpenApiConfig", Configuration Class,
// used to configure Swagger
@Configuration
public class OpenApiConfig {

    /*
     * CommandLineRunner openApiGroups()
     * This method is used to configure Swagger
     * mapping the service name to the group name
     */
    @Bean
    public CommandLineRunner openApiGroups(
            RouteDefinitionLocator locator,
            SwaggerUiConfigParameters swaggerUiParameters) {
        return args -> locator.getRouteDefinitions().collectList().block().stream().map(RouteDefinition::getId)
                .filter(id -> id.matches(".*-service")).map(id -> id.replace("-service", ""))
                .forEach(swaggerUiParameters::addGroup);

    }

}
