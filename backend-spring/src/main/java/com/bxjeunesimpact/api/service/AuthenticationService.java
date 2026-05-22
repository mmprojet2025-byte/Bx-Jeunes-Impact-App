package com.bxjeunesimpact.api.service;

import com.bxjeunesimpact.api.dto.request.AuthenticationRequest;
import com.bxjeunesimpact.api.dto.request.UserCreateRequest;
import com.bxjeunesimpact.api.dto.response.AuthenticationResponse;
import com.bxjeunesimpact.api.dto.response.UserResponse;
import com.bxjeunesimpact.api.entity.RefreshToken;
import com.bxjeunesimpact.api.entity.User;
import com.bxjeunesimpact.api.entity.enums.Role;
import com.bxjeunesimpact.api.mapper.UserMapper;
import com.bxjeunesimpact.api.repository.RefreshTokenRepository;
import com.bxjeunesimpact.api.repository.UserRepository;
import com.bxjeunesimpact.api.security.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class AuthenticationService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final RefreshTokenRepository refreshTokenRepository;
    private final UserMapper userMapper;

    @Transactional
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

        user = userRepository.save(user);

        // Génération des tokens
        var jwtToken = jwtService.generateToken(user);
        var refreshToken = jwtService.generateRefreshToken(user);

        // Sauvegarde du Refresh Token en BDD pour ce nouvel utilisateur
        RefreshToken rt = new RefreshToken();
        rt.setToken(refreshToken);
        rt.setExpiryDate(java.time.Instant.now().plusMillis(604800000L)); // 7 jours
        rt.setUser(user);
        refreshTokenRepository.save(rt);

        // On mappe l'entité User vers le DTO UserResponse
        UserResponse userResponse = userMapper.toResponse(user);

        // On retourne le bon constructeur !
        return new AuthenticationResponse(userResponse, jwtToken, refreshToken, 900L); // 900s = 15 min
    }

    @Transactional
    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        // 1. Spring Security s'occupe de vérifier email + mot de passe
        // S'ils sont faux, cela lance automatiquement une BadCredentialsException (401)
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.email(), request.password())
        );

        // 2. Si on arrive ici, les identifiants sont bons. On récupère l'utilisateur.
        var user = userRepository.findByEmail(request.email()).orElseThrow();

        // 3. Génération des nouveaux tokens
        var jwtToken = jwtService.generateToken(user);
        var refreshToken = jwtService.generateRefreshToken(user);

        // 4. Mise à jour du token en base (on supprime l'ancien s'il existe, on crée le nouveau)
        refreshTokenRepository.deleteByUserId(user.getId());
        RefreshToken rt = new RefreshToken();
        rt.setToken(refreshToken);
        rt.setExpiryDate(java.time.Instant.now().plusMillis(604800000L)); // 7 jours
        rt.setUser(user);
        refreshTokenRepository.save(rt);

        // 5. On prépare la réponse avec le UserResponse complet
        UserResponse userResponse = userMapper.toResponse(user);

        return new AuthenticationResponse(userResponse, jwtToken, refreshToken, 900L); // 900s = 15 min
    }
    @Transactional(readOnly = true)
    public UserResponse toUserResponse(User user) {
        Set<String> roleNames = user.getRoles().stream()
                .map(Enum::name)
                .collect(java.util.stream.Collectors.toSet());

        return new UserResponse(
                user.getId(),
                user.getEmail(),
                user.getFirstName(),
                user.getLastName(),
                roleNames,
                user.getGroup() != null ? user.getGroup().getId() : null,
                user.getGroup() != null ? user.getGroup().getName() : null,
                user.isActive()
        );
    }
    @Transactional(readOnly = true)
    public UserResponse getCurrentUser(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Utilisateur introuvable"));
        return toUserResponse(user);
    }
}