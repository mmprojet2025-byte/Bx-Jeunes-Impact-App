package com.bxjeunesimpact.api.entity;

import com.bxjeunesimpact.api.entity.enums.ProjectStatus;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDateTime;

@Entity
@Table(name = "projects")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "project_status_enum")
    private ProjectStatus status = ProjectStatus.PENDING;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "creator_id", nullable = false)
    private User creator;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "group_id")
    private Group group;

    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "validated_by_referent_id")
    private User validatedByReferent;

    @Column(name = "referent_validation_date")
    private LocalDateTime referentValidationDate;

    @Column(name = "referent_validation_comment", columnDefinition = "TEXT")
    private String referentValidationComment;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "validated_by_admin_id")
    private User validatedByAdmin;

    @Column(name = "admin_validation_date")
    private LocalDateTime adminValidationDate;

    @Column(name = "admin_validation_comment", columnDefinition = "TEXT")
    private String adminValidationComment;

    // ---------------------------------------------

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}