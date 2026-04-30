package com.bxjeunesimpact.api.entity.enums;

public enum ProjectStatus {
    PENDING,                  // En attente
    VALIDATED_BY_REFERENT,    // Validé par le référent
    REFUSED_BY_REFERENT,      // Refusé par le référent
    TRANSMITTED_TO_ADMIN,     // Transmis à l'admin
    VALIDATED_BY_ADMIN,       // Validé par l'admin (final)
    REFUSED_BY_ADMIN,         // Refusé par l'admin
    VISIBLE_TO_PARTNERS,      // Visible aux partenaires
    COMPLETED                 // Terminé
}