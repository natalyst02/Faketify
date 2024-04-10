package com.mobile.api.controller.admin.request;

import com.mobile.shared.db.entities.Artist;
import lombok.Data;

@Data
public class AddSongRequest {
    private Artist artist;

    private String name;

    private Integer duration;

    private String source;

    private Integer publishYear;
}

