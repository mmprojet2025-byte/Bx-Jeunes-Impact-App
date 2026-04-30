package com.bxjeunesimpact.api.dto.response;

import com.bxjeunesimpact.api.entity.enums.Role;
import java.util.Set;

public record UserResponse(
    Long id,
    String email,
    String firstName,
    String lastName,
    Set<Role> roles,
    Long groupId,
    String groupName,
    boolean active
) {}