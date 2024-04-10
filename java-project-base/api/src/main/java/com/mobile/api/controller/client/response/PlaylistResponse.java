package com.mobile.api.controller.client.response;

import com.mobile.shared.db.entities.Playlist;
import lombok.Builder;
import lombok.Data;

import java.time.Instant;

@Data
@Builder
public class PlaylistResponse {
    private Long id;

    private String name;

    private String image;

    private Instant createdAt;

    private SongDetailResponseV2 firstSong;

    public static PlaylistResponse from(Playlist playlist, SongDetailResponse songDetailResponse) {
        return PlaylistResponse.builder()
                .id(playlist.getId())
                .name(playlist.getName())
                .image(songDetailResponse.getImage())
                .firstSong(SongDetailResponseV2.from(songDetailResponse))
                .createdAt(playlist.getCreatedAt())
                .build();
    }

    @Data
    @Builder
    public static class SongDetailResponseV2 {
        public Long songId;

        public String songName;

        public String image;

        public String artistName;

        private Long albumId;

        private String albumName;

        private String albumImage;

        public static SongDetailResponseV2 from(SongDetailResponse response) {
            return SongDetailResponseV2.builder()
                    .songId(response.getSongId())
                    .songName(response.getSongName())
                    .image(response.getImage())
                    .artistName(response.getArtistName())
                    .albumId((response.getAlbums() == null || response.getAlbums().isEmpty()) ? null : response.getAlbums().get(0).getAlbumId())
                    .albumName((response.getAlbums() == null || response.getAlbums().isEmpty()) ? null : response.getAlbums().get(0).getAlbumName())
                    .albumImage((response.getAlbums() == null || response.getAlbums().isEmpty()) ? null : response.getAlbums().get(0).getAlbumImage())
                    .build();
        }
    }
}
