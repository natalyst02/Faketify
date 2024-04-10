package com.mobile.shared.db.repo;

import com.mobile.shared.db.entities.Song;
import com.mobile.shared.db.entities.User;
import com.mobile.shared.db.entities.UserFavouriteSong;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserFavouriteSongRepository extends JpaRepository<UserFavouriteSong, Long> {
    Optional<UserFavouriteSong> findByUserAndSong(User user, Song song);

    List<UserFavouriteSong> findAllByUser(User user);
}
