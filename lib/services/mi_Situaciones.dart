// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class Situation {
  final String id;
  final DateTime fecha;
  final String titulo;
  final String descripcion;
  final String estado;
  final String comentarios;
  final String foto;
  final String token;

  Situation({
    required this.id,
    required this.fecha,
    required this.titulo,
    required this.descripcion,
    required this.estado,
    required this.comentarios,
    required this.foto,
    required this.token,
  });
}

class MisSituacionesPage extends StatelessWidget {
  const MisSituacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mis Situaciones',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySituationsPage(),
    );
  }
}

class MySituationsPage extends StatefulWidget {
  const MySituationsPage({Key? key}) : super(key: key);

  @override
  _MySituationsPageState createState() => _MySituationsPageState();
}

class _MySituationsPageState extends State<MySituationsPage> {
  List<Situation> situations = [];

  @override
  void initState() {
    super.initState();
    fetchSituations(); // Llama a la función para obtener las situaciones al iniciar la pantalla
  }

  Future<void> fetchSituations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      final String apiUrl = 'https://adamix.net/defensa_civil/def/situaciones.php'; // Reemplaza con la URL correcta
      try {
        final response = await http.get(
          Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);
          if (data['exito'] == true) {
            List<dynamic> situationsData = data['datos'];
            setState(() {
              situations = situationsData.map((situation) {
                return Situation(
                  id: situation['id'],
                  fecha: DateTime.parse(situation['fecha']),
                  titulo: situation['titulo'],
                  descripcion: situation['descripcion'],
                  estado: situation['estado'],
                  comentarios: situation['comentarios'],
                  foto: situation['foto'],
                  token: token, // Asegúrate de pasar el token a cada situación
                );
              }).toList();
            });
          } else {
            throw Exception('Error: ${data['mensaje']}');
          }
        } else {
          throw Exception('Failed to load situations');
        }
      } catch (e) {
        print('Error fetching situations: $e');
      }
    } else {
      print('Token not found in SharedPreferences');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Situaciones'),
      ),
      body: ListView.builder(
        itemCount: situations.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(situations[index].titulo),
            subtitle: Text('Reportado el ${situations[index].fecha.toString()}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SituationDetailsPage(situation: situations[index])),
              );
            },
          );
        },
      ),
    );
  }
}


class SituationDetailsPage extends StatelessWidget {
  final Situation situation;

  const SituationDetailsPage({super.key, required this.situation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Situación'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Código de Identificación: ${situation.id}'),
            Text('Fecha: ${situation.fecha.toString()}'),
            Text('Título: ${situation.titulo}'),
            Text('Descripción: ${situation.descripcion}'),
            Text('estado: ${situation.estado}'),
            Text('comentarios: ${situation.comentarios}'),
            // Aquí puedes mostrar más detalles como la imagen, estado, comentarios, etc.
          ],
        ),
      ),
    );
  }
}
