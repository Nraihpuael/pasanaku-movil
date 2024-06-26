import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:pasanaku/models/user.dart';

class SubirQrScreen extends StatefulWidget {
  final User? user;

  const SubirQrScreen({super.key, this.user});
  @override
  _SubirQrScreenState createState() => _SubirQrScreenState();
}

class _SubirQrScreenState extends State<SubirQrScreen> {
  XFile? _image;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    print('id de user:>>>>>> ${widget.user!.id}');
    setState(() {
      _image = pickedFile;
    });

    if (_image != null) {
      // Envía la imagen al API
      await _uploadImage(_image!.path);
    }
  }

  Future<void> _uploadImage(String imagePath) async {
    // URL del endpoint de tu API
    final url = Uri.parse(
        'https://pasanaku-api.adaptable.app/api/jugadores/subirImagen/${widget.user!.id}');

    // Crear una solicitud de tipo POST
    final request = http.MultipartRequest('POST', url);

    // Adjuntar la imagen al cuerpo de la solicitud
    request.files.add(
      await http.MultipartFile.fromPath(
        'imagen',
        imagePath,
        filename: imagePath.split('/').last,
      ),
    );
    print(request.files);
    // Enviar la solicitud y esperar la respuesta
    final response = await http.Response.fromStream(await request.send());
    print(response.body);

    print("Respuesta de bode subir: =>> ${response.statusCode}");
    if (response.statusCode == 201) {
      print('Imagen enviada exitosamente al API');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('QR subido con éxito',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          duration: Duration(seconds: 2), // Duración de la notificación
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(Duration(seconds: 2), () {
        context.push('/home');
        //context.go('/home');
      });

      // Aquí puedes manejar cualquier lógica adicional después de enviar la imagen
    } else {
      print('Error al enviar la imagen al API: ${response.reasonPhrase}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Fallo al momento de subir el Qr, intentelo de nuevo',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          duration: Duration(seconds: 2), // Duración de la notificación
          backgroundColor: Colors.red,
        ),
      );
      // Aquí puedes manejar cualquier error que ocurra durante la solicitud
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir QR'),
      ),
      body: Center(
        child: _image == null
            ? Text('No Seleccionaste una imagen.')
            : Image.file(
                File(_image!.path),
                width: 200,
                height: 200,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Selecciona una imagen',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
