import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReportSituationPage extends StatefulWidget {
  const ReportSituationPage({Key? key}) : super(key: key);

  @override
  _ReportSituationPageState createState() => _ReportSituationPageState();
}

class _ReportSituationPageState extends State<ReportSituationPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _imageBytes; // Almacenar la imagen como bytes
  String? _imageUrl;

  Future<void> _reportSituation() async {
    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();

    if (title.isEmpty ||
        description.isEmpty ||
        (_imageBytes == null && _imageUrl == null)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Por favor completa todos los campos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Convierte la imagen a base64 si se seleccionó desde la galería
    String base64Image = '';
    if (_imageBytes != null) {
      base64Image = base64Encode(_imageBytes!);
    }

    // Envía la solicitud POST a la API
    // Envía la solicitud POST a la API
    final response = await http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/nueva_situacion.php'),
      body: {
        'titulo': title,
        'descripcion': description,
        'foto': base64Image,
        'latitud': '0', // Latitud de ejemplo, debes obtenerla del dispositivo
        'longitud': '0', // Longitud de ejemplo, debes obtenerla del dispositivo
        'token': [],
      },
    );

    // Procesa la respuesta
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    if (responseData['exito'] == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Éxito'),
            content: const Text('La situación ha sido reportada exitosamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Vuelve a la pantalla anterior
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Ha ocurrido un error al reportar la situación.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes(); // Lee el archivo como bytes
      setState(() {
        _imageBytes = bytes;
        _imageUrl = null;
      });
    }
  }

  Future<void> _getImageFromUrl(String imageUrl) async {
    setState(() {
      _imageBytes = null;
      _imageUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Situación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
            ),
            const SizedBox(height: 10),
            if (_imageBytes != null)
              Image.memory(_imageBytes!, height: 150)
            else if (_imageUrl != null)
              CachedNetworkImage(
                imageUrl: _imageUrl!,
                height: 150,
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _getImageFromGallery,
                  child: const Text('Seleccionar Imagen de la Galería'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _getImageFromUrl('URL_DE_LA_IMAGEN_AQUÍ');
                  },
                  child: const Text('Usar URL de Imagen'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _reportSituation,
              child: const Text('Reportar Situación'),
            ),
          ],
        ),
      ),
    );
  }
}
