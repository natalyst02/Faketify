package com.mobile.api.service.client.dto;

import lombok.Data;
import org.springframework.data.annotation.CreatedDate;

import java.time.Instant;
import java.time.LocalDate;

@Data
public class CreateUserInput {
    private String name;

    private String username;

    private String phoneNumber;

    private String avatar;

    private LocalDate birthday;

    private String gmail;

    private String password;

    @CreatedDate
    private Instant createdAt;
}
