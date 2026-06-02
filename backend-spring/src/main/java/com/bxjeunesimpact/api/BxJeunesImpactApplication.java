package com.bxjeunesimpact.api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.persistence.autoconfigure.EntityScan;

@SpringBootApplication
@EntityScan("com.bxjeunesimpact.api")
public class BxJeunesImpactApplication {

	public static void main(String[] args) {
		SpringApplication.run(BxJeunesImpactApplication.class, args);
	}

}
