package com.bxjeunesimpact.api.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "sponsorings")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Sponsoring {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "partner_id", nullable = false)
    private Partner partner;

    // Peut être nul si le sponsor finance une activité
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_id")
    private Project project;

    // Peut être nul si le sponsor finance un projet
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "activity_id")
    private Activity activity;

    @Column(precision = 10, scale = 2)
    private BigDecimal amount;

    @Column(name = "material_support", columnDefinition = "TEXT")
    private String materialSupport;

    @Column(length = 50)
    private String status = "PENDING";

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}