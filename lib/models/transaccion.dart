import 'dart:convert';

Transaccion transaccionFromJson(String str) => Transaccion.fromJson(json.decode(str));

String transaccionToJson(Transaccion data) => json.encode(data.toJson());

class Transaccion {
    int? id;
    int? monto;
    DateTime? fecha;
    String? estado;
    String? partida;
    String? ronda;
    Deudor? deudor;
    Receptor? receptor;
    List<Transaccion> toList = [];

    Transaccion({
        this.id,
        this.monto,
        this.fecha,
        this.estado,
        this.partida,
        this.ronda,
        this.deudor,
        this.receptor,
    });

    factory Transaccion.fromJson(Map<String, dynamic> json) => Transaccion(
        id: json["id"],
        monto: json["monto"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        partida: json["partida"],
        ronda: json["ronda"],
        deudor: Deudor.fromJson(json["deudor"]),
        receptor: Receptor.fromJson(json["receptor"]),
    );

    Transaccion.fromJsonList(List<dynamic> jsonList){
      if (jsonList == null) return;
        jsonList.forEach((item) {
          
          Transaccion transaccion = Transaccion.fromJson(item);
          //print("invitacion::: ${invitacion.jugadorNombre}");
          toList.add(transaccion);
      });
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "monto": monto,
        "fecha": fecha?.toIso8601String(),
        "estado": estado,
        "partida": partida,
        "ronda": ronda,
        "deudor": deudor?.toJson(),
        "receptor": receptor?.toJson(),
    };
}

class Deudor {
    int? id;
    String? nombre;

    Deudor({
        this.id,
        this.nombre,
    });

    factory Deudor.fromJson(Map<String, dynamic> json) => Deudor(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}

class Receptor {
    int? id;
    String? nombre;
    String? imagen;

    Receptor({
        this.id,
        this.nombre,
        this.imagen,
    });

    factory Receptor.fromJson(Map<String, dynamic> json) => Receptor(
        id: json["id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagen": imagen,
    };
}

/*
Transaccion.fromJsonList(List<dynamic> jsonList){
      if (jsonList == null) return;
        jsonList.forEach((item) {
          
          Transaccion transaccion = Transaccion.fromJson(item);
          //print("invitacion::: ${invitacion.jugadorNombre}");
          toList.add(transaccion);
      });
    } */