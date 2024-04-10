package com.mobile.api.service.admin;

import com.mobile.api.controller.admin.request.AddArtistRequest;
import com.mobile.api.controller.admin.request.AddSongRequest;
import com.mobile.shared.db.entities.Artist;
import com.mobile.shared.db.repo.ArtistRepository;
import com.mobile.shared.db.repo.SongRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {
    private final SongRepository songRepository;
    private final ArtistRepository artistRepository;

    @Override
    public void addSong(AddSongRequest request) {
        return;
    }

    @Override
    public void addArtist(AddArtistRequest request) {
        artistRepository.save(
            Artist.builder()
                    .name(request.getName())
                    .description(request.getDescription())
                    .avatar(request.getAvatar())
                    .foundedYear(request.getFoundedYear())
                    .bandMember(request.getBandMember())
                    .type(request.getType())
                .build()
        );
    }


}
