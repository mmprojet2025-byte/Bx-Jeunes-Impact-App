package com.bxjeunesimpact.api.dto.response;

import com.bxjeunesimpact.api.entity.enums.ActivityCategory;
import java.time.LocalDateTime;

public record ActivityResponse(
    Long id,
    String name,
    String description,
    LocalDateTime date,
    ActivityCategory category,
    Long groupId,
    String groupName
) {}