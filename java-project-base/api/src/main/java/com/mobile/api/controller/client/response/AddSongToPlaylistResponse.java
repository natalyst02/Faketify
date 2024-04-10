package com.mobile.api.controller.client.response;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class AddSongToPlaylistResponse {
    private Long songId;

    private Long playlistId;

    private Integer position;
}
