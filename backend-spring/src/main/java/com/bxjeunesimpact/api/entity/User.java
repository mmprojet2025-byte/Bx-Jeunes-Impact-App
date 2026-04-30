package com.bxjeunesimpact.api.entity;

import com.bxjeunesimpact.api.entity.enums.Role;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.Collection;
import java.util.stream.Collectors;

@Entity
@Table(name = "users")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class User implements UserDetails{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false, name = "first_name")
    private String firstName;

    @Column(nullable = false, name = "last_name")
    private String lastName;

    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_roles", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    @Column(name = "role")
    private Set<Role> roles = new HashSet<>();

    // Un jeune appartient à un seul groupe (Correction de l'architecture)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "group_id")
    private Group group;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Soft delete : l'utilisateur n'est jamais supprimé, juste désactivé
    @Column(nullable = false)
    private boolean active = true; 


    // ==========================================
    // MÉTHODES SPRING SECURITY (UserDetails)
    // ==========================================

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // Transforme notre Set<Role> en une liste de SimpleGrantedAuthority (format requis par Spring)
        return roles.stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role.name()))
                .collect(Collectors.toList());
    }

    @Override
    public String getUsername() {
        // Dans notre système, l'identifiant de connexion est l'email !
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return active; // Si active est false, le compte est verrouillé (Soft delete)
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return active; // Si active est false, le compte est désactivé
    }
}