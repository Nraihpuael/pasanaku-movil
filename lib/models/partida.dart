
import 'dart:convert';

Partida partidaFromJson(String str) => Partida.fromJson(json.decode(str));

String partidaToJson(Partida data) => json.encode(data.toJson());

class Partida {
    int? id;
    String? nombre;
    int? pozo;
    int? participantes;
    int? coutaInicial;
    DateTime? fechaInicio;
    String? lapso;
    String? estado;
    List<RondasEnpartida>? rondasEnpartida;
    Moneda? moneda;

    Partida({
        this.id,
        this.nombre,
        this.pozo,
        this.participantes,
        this.coutaInicial,
        this.fechaInicio,
        this.lapso,
        this.estado,
        this.rondasEnpartida,
        this.moneda,
    });

    factory Partida.fromJson(Map<String, dynamic> json) => Partida(
        id: json["id"],
        nombre: json["nombre"],
        pozo: json["pozo"],
        participantes: json["participantes"],
        coutaInicial: json["coutaInicial"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        lapso: json["lapso"],
        estado: json["estado"],
        rondasEnpartida: List<RondasEnpartida>.from(json["rondasEnpartida"].map((x) => RondasEnpartida.fromJson(x))),
        moneda: Moneda.fromJson(json["moneda"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "pozo": pozo,
        "participantes": participantes,
        "coutaInicial": coutaInicial,
        "fechaInicio": fechaInicio?.toIso8601String(),
        "lapso": lapso,
        "estado": estado,
        "rondasEnpartida": List<dynamic>.from(rondasEnpartida!.map((x) => x.toJson())),
        "moneda": moneda?.toJson(),
    };
}

class Moneda {
    int id;
    String nombre;

    Moneda({
        required this.id,
        required this.nombre,
    });

    factory Moneda.fromJson(Map<String, dynamic> json) => Moneda(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}

class RondasEnpartida {
    int id;
    String nombre;
    DateTime fechaInicio;
    String estado;

    RondasEnpartida({
        required this.id,
        required this.nombre,
        required this.fechaInicio,
        required this.estado,
    });

    factory RondasEnpartida.fromJson(Map<String, dynamic> json) => RondasEnpartida(
        id: json["id"],
        nombre: json["nombre"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "fechaInicio": fechaInicio.toIso8601String(),
        "estado": estado,
    };
}