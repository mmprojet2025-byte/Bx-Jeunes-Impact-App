package com.bxjeunesimpact.api.dto.response;

import java.util.Set;

public record UserResponse(
    Long id,
    String email,
    String firstName,
    String lastName,
    Set<String> roles,
    Long groupId,
    String groupName,
    boolean active
) {}