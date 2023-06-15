package gcu.backend.authservice.global.oauth2.userinfo;

import java.util.Map;

// "GoogleOAuth2UserInfo" Class extends "OAuth2UserInfo" Abstract Class
// this data is extracted from the OAuth2 service to which the user is connected
public class GoogleOAuth2UserInfo extends OAuth2UserInfo {

    /*
     * GoogleOAuth2UserInfo Constructor
     * 
     * Args:
     * - attributes: Map<String, Object> : user's information
     * 
     * Return:
     * - None
     */
    public GoogleOAuth2UserInfo(Map<String, Object> attributes) {
        super(attributes);
    }

    /*
     * getId Method
     * Get the user's unique identifier
     *
     * Args:
     * - None
     * 
     * Return:
     * - String : user's unique identifier
     */
    @Override
    public String getId() {
        return (String) attributes.get("sub");
    }

    /*
     * getNickname Method
     * Get the user's nickname
     * 
     * Args:
     * - None
     * 
     * Return:
     * - String : user's nickname
     */
    @Override
    public String getNickname() {
        return (String) attributes.get("name");
    }

    /*
     * getImageUrl Method
     * Get the user's profile image URL
     * 
     * Args:
     * - None
     * 
     * Return:
     * - String : user's profile image URL
     */
    @Override
    public String getImageUrl() {
        return (String) attributes.get("picture");
    }

    /*
     * getEmail Method
     * Get the user's email address
     * 
     * Args:
     * - None
     * 
     * Return:
     * - String : user's email address
     */
    @Override
    public String getEmail() {
        return (String) attributes.get("email");
    }
}