import 'dart:convert';

Subasta subastaFromJson(String str) => Subasta.fromJson(json.decode(str));

String subastaToJson(Subasta data) => json.encode(data.toJson());

class Subasta {
    int id;
    DateTime fechaInicio;
    DateTime fechaFinal;
    int jugadorId;
    String ganador;
    int resultado;
    String estado;

    Subasta({
        required this.id,
        required this.fechaInicio,
        required this.fechaFinal,
        required this.jugadorId,
        required this.ganador,
        required this.resultado,
        required this.estado,
    });

    factory Subasta.fromJson(Map<String, dynamic> json) => Subasta(
        id: json["id"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFinal: DateTime.parse(json["fechaFinal"]),
        jugadorId: json["jugadorId"],
        ganador: json["ganador"],
        resultado: json["resultado"],
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fechaInicio": fechaInicio.toIso8601String(),
        "fechaFinal": fechaFinal.toIso8601String(),
        "jugadorId": jugadorId,
        "ganador": ganador,
        "resultado": resultado,
        "estado": estado,
    };
}
