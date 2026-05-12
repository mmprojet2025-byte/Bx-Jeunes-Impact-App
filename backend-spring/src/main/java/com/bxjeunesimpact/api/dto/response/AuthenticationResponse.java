package com.bxjeunesimpact.api.dto.response;

public record AuthenticationResponse(
    UserResponse user,
    String accessToken,
    String refreshToken,
    long expiresIn
) {}