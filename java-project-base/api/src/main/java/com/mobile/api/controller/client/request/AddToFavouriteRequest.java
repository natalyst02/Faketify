package com.mobile.api.controller.client.request;

import lombok.Data;

@Data
public class AddToFavouriteRequest {
    private Long userId;

    private Long songId;
}
