package org.example.proyectoprofesionalteg.Entities;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.time.OffsetDateTime;

@Entity
@Setter
@Getter
@Table(name = "player")
public class playerEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String nickname;

    private String color;

    private String avatar;

    private Boolean isBot;

    private String state;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private OffsetDateTime createdAt= OffsetDateTime.now();


}
