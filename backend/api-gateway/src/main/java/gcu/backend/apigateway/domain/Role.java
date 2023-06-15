package gcu.backend.apigateway.domain;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

// "Role", used to specify the role
@Getter
@RequiredArgsConstructor
public enum Role {

    GUEST("ROLE_GUEST"), USER("ROLE_USER");

    private final String key;
}