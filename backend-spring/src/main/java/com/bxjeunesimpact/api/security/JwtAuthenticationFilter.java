package com.bxjeunesimpact.api.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final UserDetailsService userDetailsService;

    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain
    ) throws ServletException, IOException {

        // 1. On cherche le header "Authorization"
        final String authHeader = request.getHeader("Authorization");
        final String jwt;
        final String userEmail;

        // Si le header est vide ou ne commence pas par "Bearer ", on passe au filtre suivant (la requête sera probablement rejetée plus tard)
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        // 2. On extrait le token (en enlevant les 7 premiers caractères "Bearer ")
        jwt = authHeader.substring(7);
        
        // 3. On extrait l'email du token
        userEmail = jwtService.extractUsername(jwt);

        // 4. Si on a un email ET que l'utilisateur n'est pas encore authentifié dans le contexte actuel
        if (userEmail != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            
            // On charge l'utilisateur depuis la base de données
            UserDetails userDetails = this.userDetailsService.loadUserByUsername(userEmail);

            // 5. On vérifie si le token est valide
            if (jwtService.isTokenValid(jwt, userDetails)) {
                
                // On crée un jeton d'authentification pour Spring Security
                UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                        userDetails,
                        null,
                        userDetails.getAuthorities()
                );
                authToken.setDetails(
                        new WebAuthenticationDetailsSource().buildDetails(request)
                );
                
                // 6. On informe Spring Security que l'utilisateur est authentifié
                SecurityContextHolder.getContext().setAuthentication(authToken);
            }
        }
        
        // On continue la chaîne de filtres
        filterChain.doFilter(request, response);
    }
}