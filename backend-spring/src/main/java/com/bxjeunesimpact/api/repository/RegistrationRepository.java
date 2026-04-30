package com.bxjeunesimpact.api.repository;

import com.bxjeunesimpact.api.entity.Registration;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface RegistrationRepository extends JpaRepository<Registration, Long> {
    boolean existsByUserIdAndActivityId(Long userId, Long activityId);
    List<Registration> findByUserId(Long userId);
}