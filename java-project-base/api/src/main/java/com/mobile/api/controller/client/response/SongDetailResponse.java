package com.mobile.api.controller.client.response;

import com.mobile.shared.db.entities.Album;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SongDetailResponse {
    public Long songId;

    public String songName;

    public String image;

    public String artistName;

    public List<AlbumOutput> albums;

    public Integer position;

    public Integer publishYear;

    public Instant createdAt;

    @Data
    @Builder
    public static class AlbumOutput {
        private Long albumId;

        private String albumName;

        private String albumImage;

        public static AlbumOutput fromAlbum(Album album) {
            return AlbumOutput.builder()
                    .albumId(album.getId())
                    .albumName(album.getTitle())
                    .albumImage(album.getImage())
                    .build();
        }
    }
}
