package com.bxjeunesimpact.api.dto.response;

import com.bxjeunesimpact.api.entity.enums.ProjectStatus;
import java.time.LocalDateTime;

public record ProjectResponse(
    Long id,
    String title,
    String description,
    ProjectStatus status,
    Long creatorId,
    String creatorName,
    Long groupId,
    String groupName,
    LocalDateTime createdAt
) {}