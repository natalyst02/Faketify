package com.mobile.shared.db.repo;

import com.mobile.shared.db.entities.AlbumArtist;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AlbumArtistRepository extends JpaRepository<AlbumArtist, Long> {
}
