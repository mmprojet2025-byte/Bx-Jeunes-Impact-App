package com.bxjeunesimpact.api.repository;

import com.bxjeunesimpact.api.entity.Activity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDateTime;
import java.util.List;

public interface ActivityRepository extends JpaRepository<Activity, Long> {
    List<Activity> findByDateAfter(LocalDateTime date);
    List<Activity> findByGroupId(Long groupId);
}