package com.bxjeunesimpact.api.dto.response;

public record AuthenticationResponse(
    String accessToken,
    String refreshToken,
    String email,
    Long userId
) {}