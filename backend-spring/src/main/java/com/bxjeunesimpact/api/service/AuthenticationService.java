package com.bxjeunesimpact.api.service;

import com.bxjeunesimpact.api.dto.request.AuthenticationRequest;
import com.bxjeunesimpact.api.dto.request.UserCreateRequest;
import com.bxjeunesimpact.api.dto.response.AuthenticationResponse;
import com.bxjeunesimpact.api.entity.User;
import com.bxjeunesimpact.api.entity.enums.Role;
import com.bxjeunesimpact.api.repository.UserRepository;
import com.bxjeunesimpact.api.security.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
@RequiredArgsConstructor
public class AuthenticationService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    public AuthenticationResponse register(UserCreateRequest request) {
        // Vérification si l'email existe déjà
        if (userRepository.existsByEmail(request.email())) {
            throw new IllegalStateException("Cet email est déjà utilisé.");
        }

        // Création de l'utilisateur
        User user = new User();
        user.setEmail(request.email());
        user.setPassword(passwordEncoder.encode(request.password())); // Hachage du mot de passe !
        user.setFirstName(request.firstName());
        user.setLastName(request.lastName());
        user.setRoles(Set.of(Role.YOUTH)); // Rôle par défaut
        user.setActive(true);

        userRepository.save(user);

        // Génération des tokens
        var jwtToken = jwtService.generateToken(user);
        var refreshToken = jwtService.generateRefreshToken(user);

        return new AuthenticationResponse(jwtToken, refreshToken, user.getEmail(), user.getId());
    }

    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        // Spring Security s'occupe de vérifier que le mot de passe correspond à l'email
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.email(), request.password())
        );

        // Si on arrive ici, l'utilisateur est authentifié avec succès
        var user = userRepository.findByEmail(request.email()).orElseThrow();

        // Génération de nouveaux tokens
        var jwtToken = jwtService.generateToken(user);
        var refreshToken = jwtService.generateRefreshToken(user);

        return new AuthenticationResponse(jwtToken, refreshToken, user.getEmail(), user.getId());
    }
}