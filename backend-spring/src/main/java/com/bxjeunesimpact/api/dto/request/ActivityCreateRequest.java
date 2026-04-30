package com.bxjeunesimpact.api.dto.request;

import com.bxjeunesimpact.api.entity.enums.ActivityCategory;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDateTime;

public record ActivityCreateRequest(
    @NotBlank(message = "Le nom est obligatoire")
    String name,

    String description,

    @NotNull(message = "La date est obligatoire")
    LocalDateTime date,

    @NotNull(message = "La catégorie est obligatoire")
    ActivityCategory category,

    Long groupId // Optionnel
) {}