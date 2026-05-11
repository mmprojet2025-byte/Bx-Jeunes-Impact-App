package com.bxjeunesimpact.api.mapper;

import com.bxjeunesimpact.api.dto.request.UserCreateRequest;
import com.bxjeunesimpact.api.dto.response.UserResponse;
import com.bxjeunesimpact.api.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserMapper {

    // On ignore le mot de passe et les champs techniques
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "roles", ignore = true)
    @Mapping(target = "active", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "group", ignore = true) 
    @Mapping(target = "authorities", ignore = true) // <-- LA LIGNE MAGIQUE ICI
    User toEntity(UserCreateRequest request);

    // Extraction des champs de l'entité liée (Group)
    @Mapping(target = "groupId", source = "group.id")
    @Mapping(target = "groupName", source = "group.name")
    UserResponse toResponse(User user);
}