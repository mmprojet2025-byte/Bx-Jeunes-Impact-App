package com.bxjeunesimpact.api.exception;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    // --- 400 BAD REQUEST (Validation des DTOs) ---
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidationException(MethodArgumentNotValidException ex, HttpServletRequest request) {
        log.warn("Erreur de validation (400) sur {} : {}", request.getRequestURI(), ex.getMessage());

        List<ErrorResponse.FieldError> fieldErrors = ex.getBindingResult().getFieldErrors().stream()
                .map(error -> new ErrorResponse.FieldError(error.getField(), error.getDefaultMessage()))
                .collect(Collectors.toList());

        ErrorResponse response = new ErrorResponse(
                LocalDateTime.now(),
                HttpStatus.BAD_REQUEST.value(),
                HttpStatus.BAD_REQUEST.getReasonPhrase(),
                "VALIDATION_FAILED",
                "Erreur de validation des données",
                request.getRequestURI(),
                fieldErrors
        );
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
    }

    // --- 404 NOT FOUND (Entité introuvable) ---
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleResourceNotFoundException(ResourceNotFoundException ex, HttpServletRequest request) {
        log.warn("Ressource non trouvée (404) sur {} : {}", request.getRequestURI(), ex.getMessage());
        return buildResponse(HttpStatus.NOT_FOUND, "RESOURCE_NOT_FOUND", ex.getMessage(), request.getRequestURI());
    }

    // --- 409 CONFLICT (Règles métier, ex: transitions de statut interdites) ---
    @ExceptionHandler(IllegalStateException.class)
    public ResponseEntity<ErrorResponse> handleIllegalStateException(IllegalStateException ex, HttpServletRequest request) {
        log.warn("État illégal (409) sur {} : {}", request.getRequestURI(), ex.getMessage());
        return buildResponse(HttpStatus.CONFLICT, "ILLEGAL_STATE", ex.getMessage(), request.getRequestURI());
    }

    // --- 401 UNAUTHORIZED (Non authentifié) ---
    @ExceptionHandler(AuthenticationException.class)
    public ResponseEntity<ErrorResponse> handleAuthenticationException(AuthenticationException ex, HttpServletRequest request) {
        log.warn("Défaut d'authentification (401) sur {} : {}", request.getRequestURI(), ex.getMessage());
        return buildResponse(HttpStatus.UNAUTHORIZED, "UNAUTHORIZED", "Authentification requise ou invalide", request.getRequestURI());
    }

    // --- 403 FORBIDDEN (Authentifié mais pas les bons droits) ---
    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ErrorResponse> handleAccessDeniedException(AccessDeniedException ex, HttpServletRequest request) {
        log.warn("Accès refusé (403) sur {} : {}", request.getRequestURI(), ex.getMessage());
        return buildResponse(HttpStatus.FORBIDDEN, "FORBIDDEN", "Vous n'avez pas les droits nécessaires pour effectuer cette action", request.getRequestURI());
    }

    // --- 500 INTERNAL SERVER ERROR (Erreur inattendue, Catch-all) ---
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleAllOtherExceptions(Exception ex, HttpServletRequest request) {
        // Pour les erreurs 500, on utilise log.error et on passe l'exception pour avoir la Stack Trace
        log.error("Erreur critique inattendue (500) sur {} : ", request.getRequestURI(), ex);
        return buildResponse(HttpStatus.INTERNAL_SERVER_ERROR, "INTERNAL_SERVER_ERROR", "Une erreur interne inattendue est survenue", request.getRequestURI());
    }

    // Méthode utilitaire pour factoriser la construction des réponses sans champs fieldErrors
    private ResponseEntity<ErrorResponse> buildResponse(HttpStatus status, String code, String message, String path) {
        ErrorResponse response = new ErrorResponse(
                LocalDateTime.now(),
                status.value(),
                status.getReasonPhrase(),
                code,
                message,
                path,
                null // pas de fieldErrors par défaut
        );
        return ResponseEntity.status(status).body(response);
    }
}