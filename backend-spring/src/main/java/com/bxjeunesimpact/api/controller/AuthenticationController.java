package com.bxjeunesimpact.api.controller;

import com.bxjeunesimpact.api.dto.request.AuthenticationRequest;
import com.bxjeunesimpact.api.dto.request.UserCreateRequest;
import com.bxjeunesimpact.api.dto.response.AuthenticationResponse;
import com.bxjeunesimpact.api.dto.response.UserResponse;
import com.bxjeunesimpact.api.entity.User;
import com.bxjeunesimpact.api.service.AuthenticationService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register(
            @Valid @RequestBody UserCreateRequest request) {
        return ResponseEntity.status(org.springframework.http.HttpStatus.CREATED)
                .body(authenticationService.register(request));
    }

    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> authenticate(
            @Valid @RequestBody AuthenticationRequest request) {
        return ResponseEntity.ok(authenticationService.authenticate(request));
    }

    @GetMapping("/me")
    public ResponseEntity<UserResponse> getCurrentUser(
            @AuthenticationPrincipal User user) {
        return ResponseEntity.ok(authenticationService.toUserResponse(user));
    }
}