package com.bxjeunesimpact.api.dto.request;

import jakarta.validation.constraints.NotBlank;

public record ProjectCreateRequest(
    @NotBlank(message = "Le titre est obligatoire")
    String title,

    @NotBlank(message = "La description est obligatoire")
    String description,

    Long groupId // Optionnel
) {}