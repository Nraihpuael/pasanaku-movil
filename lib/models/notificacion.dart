import 'dart:convert';

Notificacion notificacionFromJson(String str) => Notificacion.fromJson(json.decode(str));

String notificacionToJson(Notificacion data) => json.encode(data.toJson());

class Notificacion {
    int? id;
    String? title;
    String? body;
    String? fecha;
    List<Notificacion> toList = [];


    Notificacion({
        this.id,
        this.title,
        this.body,
        this.fecha,
    });

    factory Notificacion.fromJson(Map<String, dynamic> json) => Notificacion(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        fecha: json["fecha"],
    );
    Notificacion.fromJsonList(List<dynamic> jsonList){
      if (jsonList == null) return;
        jsonList.forEach((item) {
          
          Notificacion transaccion = Notificacion.fromJson(item);
          //print("invitacion::: ${invitacion.jugadorNombre}");
          toList.add(transaccion);
      });
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "fecha": fecha,
    };
}
