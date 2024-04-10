package com.mobile.api.service.client;

import com.mobile.api.controller.client.response.*;
import com.mobile.api.service.client.dto.CreateUserInput;
import com.mobile.api.controller.client.request.AddSongToPlaylistRequest;
import com.mobile.api.controller.client.request.AddToFavouriteRequest;
import com.mobile.api.controller.client.request.CreatePlaylistRequest;
import com.mobile.api.controller.client.request.UserLoginRequest;
import com.mobile.shared.db.entities.*;
import com.mobile.shared.db.repo.*;
import com.mobile.shared.exception.AccessDeniedException;
import com.mobile.shared.exception.MobileException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final PlaylistRepository playlistRepository;
    private final SongRepository songRepository;
    private final UserFavouriteSongRepository userFavouriteSongRepository;
    private final PlaylistSongRepository playlistSongRepository;
    private final AlbumSongRepository albumSongRepository;

    @Override
    public void createUser(CreateUserInput input) {
        User checkUser = userRepository.findByUsernameAndName(input.getUsername(), input.getName()).orElse(null);

        if (checkUser == null) {
            userRepository.save(
                    User.builder()
                            .name(input.getName())
                            .username(input.getUsername())
                            .phoneNumber(input.getPhoneNumber())
                            .avatar(input.getAvatar())
                            .birthday(input.getBirthday())
                            .email(input.getGmail())
                            .password(input.getPassword())
                            .createdAt(Instant.now())
                            .build());
        }
    }

    @Override
    public UserLoginResponse login(UserLoginRequest request) {
        request.validate();
        User user = userRepository.findByUsernameAndPassword(request.getUsername(), request.getPassword())
                .orElseThrow(AccessDeniedException::new);

        return UserLoginResponse.builder()
                .userId(user.getId())
                .username(user.getUsername())
                .build();
    }

    @Override
    public void addSongToFavourite(AddToFavouriteRequest request) {
        User user = userRepository.findById(request.getUserId()).orElse(null);
        Song song = songRepository.findById(request.getSongId()).orElse(null);
        userFavouriteSongRepository.save(
                UserFavouriteSong.builder()
                        .song(song)
                        .user(user)
                        .build()
        );
    }

    @Override
    public void removeSongFromFavourite(Long userId, Long songId) {
        User user = userRepository.findById(userId).orElseThrow(MobileException::notFoundUser);
        Song song = songRepository.findById(songId).orElseThrow(MobileException::notFoundSong);

        UserFavouriteSong userFavouriteSong = userFavouriteSongRepository.findByUserAndSong(user, song)
                .orElseThrow(MobileException::notFoundSong);
        userFavouriteSongRepository.delete(userFavouriteSong);
    }

    @Override
    public Playlist createPlaylist4User(Long userId, CreatePlaylistRequest request) {
        User user = userRepository.findById(userId).get();

        return playlistRepository.save(
                Playlist.builder()
                        .user(user)
                        .name(request.getName())
                        .image(request.getImage())
                        .createdAt(Instant.now())
                        .updatedAt(Instant.now())
                        .build()
        );
    }

    @Override
    public void deletePlaylist4User(Long playlistId) {
        playlistRepository.deleteById(playlistId);
    }

    @Override
    public List<PlaylistResponse> getAllPlaylistForUser(Long userId) {
        List<Playlist> playlists = playlistRepository.findByUser(userRepository.findById(userId).get());

        List<PlaylistResponse> list = new ArrayList<>();
        for (var playlist : playlists) {
            Song song = new Song();
            SongDetailResponse songDetailResponse = new SongDetailResponse();
            if (!songRepository.getFirstSongByPlaylist(playlist.getId()).isEmpty()) {
                song = songRepository.getFirstSongByPlaylist(playlist.getId()).get(0);
                songDetailResponse = getSongDetail(song.getId(), null);
            }
            list.add(PlaylistResponse.from(playlist, songDetailResponse));
        }

        return list;
    }

    @Override
    public AddSongToPlaylistResponse addSongPlaylist4User(Long userId, AddSongToPlaylistRequest request) {
        User user = userRepository.findById(userId).orElseThrow(MobileException::notFoundUser);
        Playlist playlist = playlistRepository.findByIdAndUser(request.getPlaylistId(), user)
                .orElseThrow(MobileException::notFoundPlaylist);
        Integer position = playlistSongRepository
                .getLastPositionOfPlaylistSong(request.getPlaylistId(), request.getSongId());

        PlaylistSong playlistSong = playlistSongRepository.save(
                PlaylistSong.builder()
                        .playlist(playlist)
                        .song(songRepository.getReferenceById(request.getSongId()))
                        .position((int) ((position == null) ? 0L : position + 1L))
                        .build()
        );

        return AddSongToPlaylistResponse.builder()
                .playlistId(request.getPlaylistId())
                .songId(request.getSongId())
                .position(playlistSong.getPosition())
                .build();
    }

    @Override
    public Object getTopListenSongForUser(Long userId) {
        return null;
    }

    @Override
    public Object getUserData(Long userId) {
        return null;
    }

    @Override
    public Object getPlaylistSongForUser(Long userId, Long playlistId) {
        return null;
    }

    @Override
    public void deleteSongFromPlaylist(Long songId, Long playlistId, Long userId) {
        User user = userRepository.getReferenceById(userId);
        Playlist playlist = playlistRepository.getReferenceById(playlistId);
        Song song = songRepository.getReferenceById(songId);

        playlistSongRepository.delete(playlistSongRepository.findByPlaylistAndSong(playlist, song).get());
    }

    @Override
    public List<SongDetailResponse> searchSong(String key) {
        if (key == null) {
            key = "";
        }
        List<Song> songs =  songRepository.searchSong("%" + key + "%");
        return songs.stream().map(item -> getSongDetail(item.getId(), null)).toList();
    }

    @Override
    public Song getSongInfo(Long songId) {
        return songRepository.findById(songId).orElseThrow(MobileException::notFoundSong);
    }

    @Override
    public SongDetailResponse getSongDetail(Long songId, Integer position) {
        Song song = songRepository.findById(songId).orElseThrow(MobileException::notFoundSong);

        List<AlbumSong> albumSongs = albumSongRepository.getAlbumSongBySong(song);

        return SongDetailResponse.builder()
                .songId(song.getId())
                .songName(song.getName())
                .image(song.getImage())
                .artistName(song.getArtist().getName())
                .albums((albumSongs.isEmpty()) ? new ArrayList<>() : albumSongs.stream().map(item -> SongDetailResponse.AlbumOutput.fromAlbum(item.getAlbum())).toList())
                .publishYear(song.getPublishYear())
                .position(position)
                .createdAt(song.getCreatedAt())
                .build();
    }


    @Override
    public GetSongInPlaylistResponse getSongInPlaylist(Long playlistId) {
        Playlist playlist = playlistRepository.findById(playlistId).orElseThrow(MobileException::notFoundPlaylist);

        List<PlaylistSong> playlistSongs = playlistSongRepository.findAllByPlaylist(playlist);
        List<SongDetailResponse> songs = playlistSongs.isEmpty() ? new ArrayList<>() : playlistSongs.stream()
                .map(item -> this.getSongDetail(item.getSong().getId(), item.getPosition()))
                .sorted(Comparator.comparing(SongDetailResponse::getPosition, Comparator.nullsFirst(Comparator.naturalOrder())))
                .toList();
        return GetSongInPlaylistResponse.builder()
                .playlistId(playlistId)
                .playlistName(playlist.getName())
                .playlistImage(playlist.getImage())
                .songs(songs)
                .build();
    }

    @Override
    public List<FavouriteSong> getUserFavouriteSong(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(MobileException::notFoundUser);
        List<UserFavouriteSong> userFavouriteSongs = userFavouriteSongRepository.findAllByUser(user);

        List<Song> songs = userFavouriteSongs.stream().map(UserFavouriteSong::getSong).toList();

        List<Long> songIds = songs.stream().map(Song::getId).toList();
        List<FavouriteSong> favouriteSongs = new ArrayList<>();

        for (Long songId : songIds) {
            SongDetailResponse songDetailResponse = getSongDetail(songId, null);
            favouriteSongs.add(
                    FavouriteSong.builder()
                            .songId(songId)
                            .songName(songDetailResponse.getSongName())
                            .image(songDetailResponse.getImage())
                            .artistName(songDetailResponse.getArtistName())
                            .albums(songDetailResponse.getAlbums())
                            .createdAt(songDetailResponse.getCreatedAt())
                          .build()
            );
        }
        return favouriteSongs;
    }
}
