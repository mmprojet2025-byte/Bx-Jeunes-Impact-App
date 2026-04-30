package com.bxjeunesimpact.api.security;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtAuthenticationFilter jwtAuthFilter;
    private final AuthenticationProvider authenticationProvider;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            // Désactivation du CSRF (inutile car nous utilisons des tokens JWT)
            .csrf(AbstractHttpConfigurer::disable)
            // Configuration des règles d'autorisation
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/auth/**").permitAll() // Toutes les requêtes vers /api/auth/ sont publiques
                .anyRequest().authenticated() // Toutes les autres requêtes nécessitent d'être authentifié
            )
            // Gestion des sessions : STATELESS (l'API ne retient rien, chaque requête doit avoir son token)
            .sessionManagement(sess -> sess.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            // On ajoute notre provider
            .authenticationProvider(authenticationProvider)
            // On insère notre filtre JWT AVANT le filtre classique de Spring Security
            .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }
}