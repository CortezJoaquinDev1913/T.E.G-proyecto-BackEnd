package org.example.proyectoprofesionalteg.Models;

import java.time.OffsetDateTime;

public class player {
    Long id;
    String nickname;
    String color;
    String avatar;
    Boolean isBot;
    String state;
    OffsetDateTime createdAt = OffsetDateTime.now();
}

