package org.example.proyectoprofesionalteg.Entities;

import jakarta.persistence.*;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.OffsetDateTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "app_user")
public class userEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    @Valid
    @NotNull
    @Column(name = "username")
    String username;

    @Valid
    @NotNull
    @Column(name = "password_hash")
    String password;

    @Valid
    @NotNull
    @Column(name = "email")
    String email;

    @Column(name = "created_at")
    OffsetDateTime createdAt=OffsetDateTime.now();


}
