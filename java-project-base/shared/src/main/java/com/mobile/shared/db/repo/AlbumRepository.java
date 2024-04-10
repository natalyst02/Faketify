package com.mobile.shared.db.repo;

import com.mobile.shared.db.entities.Album;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AlbumRepository extends JpaRepository<Album, Long> {
}
