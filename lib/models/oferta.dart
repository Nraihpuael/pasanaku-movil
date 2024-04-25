import 'dart:convert';

Oferta ofertaFromJson(String str) => Oferta.fromJson(json.decode(str));

String ofertaToJson(Oferta data) => json.encode(data.toJson());

class Oferta {
    int puja;
    int subastaId;
    int jugadorId;

    Oferta({
        required this.puja,
        required this.subastaId,
        required this.jugadorId,
    });

    factory Oferta.fromJson(Map<String, dynamic> json) => Oferta(
        puja: json["puja"],
        subastaId: json["subastaId"],
        jugadorId: json["jugadorId"],
    );

    Map<String, dynamic> toJson() => {
        "puja": puja,
        "subastaId": subastaId,
        "jugadorId": jugadorId,
    };
}