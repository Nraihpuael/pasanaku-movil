import 'dart:convert';

Juego juegoFromJson(String str) => Juego.fromJson(json.decode(str));

String juegoToJson(Juego data) => json.encode(data.toJson());

class Juego {
    int? id;
    int? cuota;
    String? estado;
    bool? recibido;
    Partidas? partida;
    List<Juego> toList = [];

    Juego({
        this.id,
        this.cuota,
        this.estado,
        this.recibido,
        this.partida,
    });

    factory Juego.fromJson(Map<String, dynamic> json) => Juego(
        id: json["id"],
        cuota: json["cuota"],
        estado: json["estado"],
        recibido: json["recibido"],
        partida: Partidas.fromJson(json["partida"]),
    );

    Juego.fromJsonList(List<dynamic> jsonList){
      if (jsonList == null) return;
        jsonList.forEach((item) {
          
          Juego juego = Juego.fromJson(item);
          //print("invitacion::: ${invitacion.jugadorNombre}");
          toList.add(juego);
      });
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "cuota": cuota,
        "estado": estado,
        "recibido": recibido,
        "partida": partida!.toJson(),
    };
}

class Partidas {
    int? id;
    String? nombre;
    int? pozo;
    int? participantes;
    int? coutaInicial;
    DateTime? fechaInicio;
    String? lapso;
    String? estado;
    Moneda? moneda;

    Partidas({
        this.id,
        this.nombre,
        this.pozo,
        this.participantes,
        this.coutaInicial,
        this.fechaInicio,
        this.lapso,
        this.estado,
        this.moneda,
    });

    factory Partidas.fromJson(Map<String, dynamic> json) => Partidas(
        id: json["id"],
        nombre: json["nombre"],
        pozo: json["pozo"],
        participantes: json["participantes"],
        coutaInicial: json["coutaInicial"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        lapso: json["lapso"],
        estado: json["estado"],
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
        "moneda": moneda?.toJson(),
    };
}

class Moneda {
    int? id;
    String? nombre;

    Moneda({
        this.id,
        this.nombre,
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
