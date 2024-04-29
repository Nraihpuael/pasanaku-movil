
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    int? id;
    String? nombre;
    String? telefono;
    String? ci;
    String? email;
    String? direccion;
    String? password;
    String? tokenMovil;

    User({
      
      this.nombre,
      this.telefono,
      this.ci,
      this.email,
      this.direccion,
      this.password,  
      this.id, 
      this.tokenMovil
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        ci: json["ci"],
        email: json["email"],
        direccion: json["direccion"],
        password: json["password"],
        tokenMovil: json["tokenMovil"]
    );

    Map<String, dynamic> toJson() => {
//        "id": id,
        "nombre": nombre,
        "telefono": telefono,
        "ci": ci,
        "email": email,
        "direccion": direccion,
        "password": password,
        "tokenMovil": tokenMovil
    };

    Map<String, dynamic> toJsonReg() => {
        "id": id,
        "nombre": nombre,
        "telefono": telefono,
        "ci": ci,
        "email": email,
        "direccion": direccion,
        "password": password,
        "tokenMovil": tokenMovil
    };
}




/*
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String? id;
    String? name;
    String? lastname;
    String? email;
    String? telefono;
    String? password;
    String? sesionToken;
    String? image;

    User({
        this.id,
        this.name,
        this.lastname,
        this.email,
        this.telefono,
        this.password,
        this.sesionToken,
        this.image,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        telefono: json["telefono"],
        password: json["password"],
        sesionToken: json["sesion_token"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "telefono": telefono,
        "password": password,
        "sesion_token": sesionToken,
        "image": image,
    };
}
*/