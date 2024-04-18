
import 'dart:convert';

import 'package:flutter/foundation.dart';

Invitacion invitacionFromJson(String str) => Invitacion.fromJson(json.decode(str));

String invitacionToJson(Invitacion data) => json.encode(data.toJson());

class Invitacion {
    int? id;
    String? nombre;
    String? telefono;
    String? email;
    String? estado;
    int? partidaId;
    int? participanteId;
    int? jugadaorId;
    List<Invitacion> toList = [];

    Invitacion({
        this.id,
        this.nombre,
        this.telefono,
        this.email,
        this.estado,
        this.partidaId,
        this.participanteId,
        this.jugadaorId,
    });

    factory Invitacion.fromJson(Map<String, dynamic> json) => Invitacion(
        id: json["id"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        email: json["email"],
        estado: json["estado"],
        partidaId: json["partidaId"],
        participanteId: json["participanteId"],
        jugadaorId: json["jugadaorId"],
    );

    Invitacion.fromJsonList(List<dynamic> jsonList){
      if (jsonList == null) return;
        jsonList.forEach((item) {
          Invitacion invitacion = Invitacion.fromJson(item);
          toList.add(invitacion);
      });
    } 

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "telefono": telefono,
        "email": email,
        "estado": estado,
        "partidaId": partidaId,
        "participanteId": participanteId,
        "jugadaorId": jugadaorId,
    };
}
