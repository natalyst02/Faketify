
package com.mobile.shared.db.repo;

import com.mobile.shared.db.entities.AlbumSong;
import com.mobile.shared.db.entities.Song;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AlbumSongRepository extends JpaRepository<AlbumSong, Long> {

    List<AlbumSong> getAlbumSongBySong(Song song);
}
