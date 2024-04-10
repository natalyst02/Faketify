package com.mobile.api.controller.client.response;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class GetSongInPlaylistResponse {
    private Long playlistId;

    private String playlistName;

    private String playlistImage;

    List<SongDetailResponse> songs;
}
