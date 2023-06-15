package gcu.backend.authservice.global.oauth2.userinfo;

import java.util.Map;

// "OAuth2UserInfo" Abstract Class
// this data is extracted from the OAuth2 service to which the user is connected
public abstract class OAuth2UserInfo {

    protected Map<String, Object> attributes;

    public OAuth2UserInfo(Map<String, Object> attributes) {
        this.attributes = attributes;
    }

    public abstract String getId(); // 소셜 식별 값 : 구글 - "sub", 카카오 - "id", 네이버 - "id"

    public abstract String getNickname();

    public abstract String getImageUrl();

    public abstract String getEmail();
}