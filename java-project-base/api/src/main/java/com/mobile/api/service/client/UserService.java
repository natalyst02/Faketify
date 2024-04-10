package com.mobile.api.service.client;

import com.mobile.api.controller.client.request.*;
import com.mobile.api.controller.client.response.*;
import com.mobile.api.service.client.dto.CreateUserInput;
import com.mobile.shared.db.entities.Playlist;
import com.mobile.shared.db.entities.Song;

import java.util.List;

public interface UserService {
    void createUser(CreateUserInput input);

    List<PlaylistResponse> getAllPlaylistForUser(Long userId);

    UserLoginResponse login(UserLoginRequest request);

    void addSongToFavourite(AddToFavouriteRequest request);

    void removeSongFromFavourite(Long userId, Long songId);

    Playlist createPlaylist4User(Long userId, CreatePlaylistRequest request);

    void deletePlaylist4User(Long playlistId);

    AddSongToPlaylistResponse addSongPlaylist4User(Long userId, AddSongToPlaylistRequest request);

    Object getTopListenSongForUser(Long userId);

    Object getUserData(Long userId);

    Object getPlaylistSongForUser(Long userId, Long playlistId);

    void deleteSongFromPlaylist(Long songId, Long playlistId, Long userId);

    List<SongDetailResponse> searchSong(String key);

    Song getSongInfo(Long songId);

    SongDetailResponse getSongDetail(Long songId, Integer position);

    GetSongInPlaylistResponse getSongInPlaylist(Long playlistId);

    List<FavouriteSong> getUserFavouriteSong(Long userId);
}
