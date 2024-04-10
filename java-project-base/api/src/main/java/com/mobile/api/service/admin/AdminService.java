package com.mobile.api.service.admin;

import com.mobile.api.controller.admin.request.AddArtistRequest;
import com.mobile.api.controller.admin.request.AddSongRequest;

public interface AdminService {
    void addSong(AddSongRequest request);

    void addArtist(AddArtistRequest request);
}
