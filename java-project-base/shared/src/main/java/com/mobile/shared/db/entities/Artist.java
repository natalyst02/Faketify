package com.mobile.shared.db.entities;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.Instant;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "artist")
@Builder
public class Artist {
    @EqualsAndHashCode.Include
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String description;

    private String avatar;

    private ArtistType type;

    private String foundedYear;

    private String bandMember;

    @CreatedDate
    private Instant createdAt;

    public enum ArtistType {
        SINGLE(1),
        BAND(2)
        ;
        private final int value;

        ArtistType(int value) {
            this.value = value;
        }
    }
}
