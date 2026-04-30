package com.bxjeunesimpact.api.repository;

import com.bxjeunesimpact.api.entity.Project;
import com.bxjeunesimpact.api.entity.enums.ProjectStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ProjectRepository extends JpaRepository<Project, Long> {
    List<Project> findByGroupId(Long groupId);
    List<Project> findByStatus(ProjectStatus status);
}