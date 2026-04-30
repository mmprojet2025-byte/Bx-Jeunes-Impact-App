package com.bxjeunesimpact.api.repository;

import com.bxjeunesimpact.api.entity.Partner; // Remplacer par Sponsoring ou News
import org.springframework.data.jpa.repository.JpaRepository;

public interface PartnerRepository extends JpaRepository<Partner, Long> {
}