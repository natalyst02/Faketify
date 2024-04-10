package com.mobile.api.controller.client.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserLoginResponse {
    private Long userId;

    private String username;
}
