package com.bxjeunesimpact.api.mapper;

import com.bxjeunesimpact.api.dto.request.ProjectCreateRequest;
import com.bxjeunesimpact.api.dto.response.ProjectResponse;
import com.bxjeunesimpact.api.entity.Project;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface ProjectMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "creator", ignore = true)
    @Mapping(target = "group", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "validatedByReferent", ignore = true)
    @Mapping(target = "referentValidationDate", ignore = true)
    @Mapping(target = "referentValidationComment", ignore = true)
    @Mapping(target = "validatedByAdmin", ignore = true)
    @Mapping(target = "adminValidationDate", ignore = true)
    @Mapping(target = "adminValidationComment", ignore = true)
    Project toEntity(ProjectCreateRequest request);

    @Mapping(target = "creatorId", source = "creator.id")
    @Mapping(target = "creatorName", expression = "java(project.getCreator().getFirstName() + ' ' + project.getCreator().getLastName())")
    @Mapping(target = "groupId", source = "group.id")
    @Mapping(target = "groupName", source = "group.name")
    ProjectResponse toResponse(Project project);
}