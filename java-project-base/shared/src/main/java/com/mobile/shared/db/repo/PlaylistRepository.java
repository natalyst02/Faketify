package com.mobile.shared.db.repo;

import com.mobile.shared.db.entities.Playlist;
import com.mobile.shared.db.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PlaylistRepository extends JpaRepository<Playlist, Long> {
    Optional<Playlist> findByIdAndUser(Long playlistId, User user);

    List<Playlist> findByUser(User user);
}
