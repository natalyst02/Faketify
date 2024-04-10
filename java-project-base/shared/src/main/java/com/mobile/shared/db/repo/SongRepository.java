package com.mobile.shared.db.repo;

import com.mobile.shared.db.entities.Song;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface SongRepository extends JpaRepository<Song, Long> {
    @Query(value = """
        select *
        from song
                 join artist on song.artist_id = artist.id
                 join album_song on song.id = album_song.song_id
                 join album on album_song.album_id = album.id
        where :searchKey = '%%'
           or :searchKey is null
           or song.name like :searchKey
           or artist.name like :searchKey
           or album.title like :searchKey
        """, nativeQuery = true)
    List<Song> searchSong(@Param("searchKey") String searchKey);

    @Query("""
        select s from PlaylistSong ps 
        join ps.song s
        where ps.playlist.id = :playlistId
        order by ps.position 
        """)
    List<Song> getFirstSongByPlaylist(@Param("playlistId") Long playlistId);
}
