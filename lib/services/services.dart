// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Servicio {
  final String nombre;
  final String descripcion;
  final String foto;

  Servicio({
    required this.nombre,
    required this.descripcion,
    required this.foto,
  });
}

class ServiciosPage extends StatefulWidget {
  const ServiciosPage({Key? key}) : super(key: key);

  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  List<Servicio> servicios = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const String apiUrl = 'https://adamix.net/defensa_civil/def/servicios.php';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> serviciosData = data['datos'];

        setState(() {
          servicios = serviciosData.map((servicio) {
            return Servicio(
              nombre: servicio['nombre'],
              descripcion: servicio['descripcion'],
              foto: servicio['foto'],
            );
          }).toList();
        });
      } else {
        throw Exception('Failed to load servicios');
      }
    } catch (e) {
      print('Error fetching servicios: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
      ),
      body: servicios.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Muestra un indicador de carga mientras se cargan los datos
          : SizedBox( // Envuelve el ListView.builder en un Container con una altura definida
        height: MediaQuery.of(context).size.height, // Puedes ajustar la altura según tus necesidades
        child: ListView.builder(
          itemCount: servicios.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(servicios[index].nombre),
              subtitle: Text(servicios[index].descripcion),
              trailing: Image.network(servicios[index].foto), // Utiliza Image.network para mostrar la foto
            );
          },
        ),
      ),
    );
  }
}


