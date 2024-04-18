
import 'dart:convert';

import 'package:flutter/foundation.dart';

Invitacion invitacionFromJson(String str) => Invitacion.fromJson(json.decode(str));

String invitacionToJson(Invitacion data) => json.encode(data.toJson());

class Invitacion {
    int? id;
    String? jugadorNombre;
    String? partidaNombre;
    int? partidaPozo;
    String? partidaFecha;
    //String? estado;
    List<Invitacion> toList = [];

    Invitacion({
        this.id,
        this.jugadorNombre,
        this.partidaNombre,
        this.partidaPozo,
        this.partidaFecha
    });

    factory Invitacion.fromJson(Map<String, dynamic> json) => Invitacion(
        id: json["id"],
        jugadorNombre: json["jugadorNombre"],
        partidaNombre: json["partidaNombre"],
        partidaPozo: json["partidaPozo"],
        partidaFecha: json["partidaFecha"]
        
    );

    factory Invitacion.fromJsonInv(Map<String, dynamic> json) => Invitacion(
        id: json["id"],
        jugadorNombre: json["jugadorNombre"],
        partidaNombre: json["partidaNombre"],
        partidaPozo: json["partidaPozo"],
        partidaFecha: json["partidaFecha"],
    );


    Invitacion.fromJsonList(List<dynamic> jsonList){
      if (jsonList == null) return;
        jsonList.forEach((item) {
          
          Invitacion invitacion = Invitacion.fromJson(item);
          //print("invitacion::: ${invitacion.jugadorNombre}");
          toList.add(invitacion);
      });
    } 

    Map<String, dynamic> toJson() => {
        "id": id,
        "jugadorNombre": jugadorNombre,
        "partidaNombre": partidaNombre,      
        "partidaPozo": partidaPozo,                
        "partidaFecha": partidaFecha,
    };
}
