package com.mobile.api.controller.client.response;

import lombok.Builder;
import lombok.Data;

import java.time.Instant;
import java.util.List;

@Data
@Builder
public class FavouriteSong {
    public Long songId;

    public String songName;

    public String image;

    public String artistName;

    public List<SongDetailResponse.AlbumOutput> albums;

    public Integer publishYear;

    public Instant createdAt;
}
