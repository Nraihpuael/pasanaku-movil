import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Para seleccionar imágenes
import 'dart:io'; // Para trabajar con archivos

class ImageScannerScreen extends StatefulWidget {
  const ImageScannerScreen({super.key});

  @override
  State<ImageScannerScreen> createState() => _ImageScannerScreenState();
}

class _ImageScannerScreenState extends State<ImageScannerScreen> {
  final ImagePicker _picker = ImagePicker(); // Selector de imágenes

  // Método para seleccionar una imagen y escanear automáticamente
  Future<void> _pickAndScanImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Llama al método para escanear la imagen después de seleccionarla
      _scanImage(File(image.path)); // Iniciar escaneo
    }
  }

  // Método para escanear la imagen y disparar una acción
  void _scanImage(File image) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Escaneando imagen...")), // Mensaje de escaneo
    );

    // Aquí puedes agregar lógica para escanear la imagen o hacer una petición
    // Ejemplo: enviar la imagen a un servidor para procesamiento
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escáner de Imágenes"),
      ),
      body: Center( // Centrar el contenido
        child: Padding(
          padding: const EdgeInsets.all(16), // Espacio para evitar bordes pegados
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Mostrar imagen estática desde assets
              Container(
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 18, 18, 18),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/qr_scanner.jpg', // Imagen estática
                    height: 30,
                  
                  ),
                ),
              ),

              const SizedBox(height: 20), // Espacio entre elementos

              ElevatedButton(
                onPressed: _pickAndScanImage, // Escanear al seleccionar
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload), // Icono de subir
                    const SizedBox(width: 10), // Espacio entre icono y texto
                    const Text("Subir Imagen"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // Para seleccionar imágenes
// import 'dart:io'; // Para trabajar con archivos

// class ImageScannerScreen extends StatefulWidget {
//   const ImageScannerScreen({super.key});

//   @override
//   State<ImageScannerScreen> createState() => _ImageScannerScreenState();
// }

// class _ImageScannerScreenState extends State<ImageScannerScreen> {
//   final ImagePicker _picker = ImagePicker(); // Objeto para seleccionar imágenes
//   File? _selectedImage; // Imagen seleccionada

//   // Método para seleccionar una imagen de la galería
//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path); // Guardar la imagen seleccionada
//       });
//     }
//   }

//   // Método para escanear la imagen y disparar una acción
//   void _scanImage() {
//     if (_selectedImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Por favor, seleccione una imagen primero.")),
//       );
//       return;
//     }

//     // Aquí puedes agregar la lógica para escanear la imagen y hacer una petición
//     // Por ejemplo, enviar la imagen a un servidor para procesarla
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Escaneando imagen...")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Escáner de Imágenes"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16), // Espacio para evitar bordes pegados
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Si hay una imagen seleccionada, mostrarla
//             if (_selectedImage != null)
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12), // Bordes redondeados
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.3),
//                       spreadRadius: 1,
//                       blurRadius: 5,
//                       offset: const Offset(2, 2), // Sombra
//                     ),
//                   ],
//                 ),
//                 child: Image.file(_selectedImage!, height: 200), // Mostrar imagen
//               ),
            
//             const SizedBox(height: 20), // Espacio entre elementos

//             ElevatedButton(
//               onPressed: _pickImage, // Seleccionar imagen
//               child: const Text("Seleccionar Imagen"),
//             ),

//             const SizedBox(height: 20), // Espacio entre elementos

//             ElevatedButton(
//               onPressed: _scanImage, // Escanear imagen
//               child: const Text("Escanear"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }