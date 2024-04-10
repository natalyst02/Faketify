package com.mobile.api.controller.client.response;

import com.mobile.shared.db.entities.Song;
import lombok.Builder;
import lombok.Data;

import java.time.Instant;

@Data
@Builder
public class SearchSongResponse {
    private Long id;

    private String artistName;

    private Long artistId;

    private String name;

    private Integer duration;

    private String source;

    private String image;

    private Integer publishYear;

    private Instant createdAt;

    public static SearchSongResponse from(Song song) {
        return SearchSongResponse.builder()
                .id(song.getId())
                .name(song.getName())
                .artistId(song.getArtist().getId())
                .artistName(song.getArtist().getName())
                .duration(song.getDuration())
                .source(song.getSource())
                .image(song.getImage())
                .publishYear(song.getPublishYear())
                .createdAt(song.getCreatedAt())
                .build();
    }
}
