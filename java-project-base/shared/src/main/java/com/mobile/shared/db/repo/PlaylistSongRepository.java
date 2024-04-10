package com.mobile.shared.db.repo;

import com.mobile.shared.db.entities.Playlist;
import com.mobile.shared.db.entities.PlaylistSong;
import com.mobile.shared.db.entities.Song;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PlaylistSongRepository extends JpaRepository<PlaylistSong, Long> {

    @Query(value = """
        select max(ps.position)
        from playlist_song ps
        where ps.playlist_id = :playlistId
        and ps.song_id = :songId
        """, nativeQuery = true)
    Integer getLastPositionOfPlaylistSong(
            @Param("playlistId") Long playlistId,
            @Param("songId") Long songId
    );

    Optional<PlaylistSong> findByPlaylistAndSong(Playlist playlist, Song song);

    List<PlaylistSong> findAllByPlaylist(Playlist playlist);
}
