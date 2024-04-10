package com.mobile.shared.db.repo;

import com.mobile.shared.db.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUsernameAndName(String username, String name);

    Optional<User> findByUsernameAndPassword(String username, String password);
}
