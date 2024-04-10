package com.mobile.shared.db.repo;

import com.mobile.shared.db.entities.Artist;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ArtistRepository extends JpaRepository<Artist, Long> {
}
