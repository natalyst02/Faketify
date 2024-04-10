package com.mobile.api.controller.admin.request;

import com.mobile.shared.db.entities.Artist;
import lombok.Data;

import java.time.LocalDate;

@Data
public class AddArtistRequest {
    private String name;

    private String description;

    private String avatar;

    private Artist.ArtistType type;

    private String foundedYear;

    private String bandMember;

}
