package com.mobile.api.controller.client.request;

import lombok.Data;

@Data
public class AddSongToPlaylistRequest {
    private Long songId;

    private Long playlistId;
}
