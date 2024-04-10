package com.mobile.shared.db.entities;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.Instant;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "song")
@Builder
public class Song {
    @EqualsAndHashCode.Include
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "artist_id")
    private Artist artist;

    private String name;

    private Integer duration;

    @Column(name = "s3_key")
    private String s3Key;

    @Column(name = "s3_file_name")
    private String s3FileName;

    private String source;

    private String image;

    private Integer publishYear;

    @CreatedDate
    private Instant createdAt;
}
