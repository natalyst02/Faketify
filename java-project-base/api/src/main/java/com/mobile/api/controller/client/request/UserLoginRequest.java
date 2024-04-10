package com.mobile.api.controller.client.request;

import com.mobile.shared.exception.AccessDeniedException;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserLoginRequest {
    private String username;

    private String password;

    public void validate() {
        if (this.username == null
            || this.username.isBlank()
            || this.password == null || this.password.isBlank()) {
            throw new AccessDeniedException();
        }
    }
}
