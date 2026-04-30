package com.bxjeunesimpact.api.repository;

import com.bxjeunesimpact.api.entity.News;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NewsRepository extends JpaRepository<News, Long> {
}