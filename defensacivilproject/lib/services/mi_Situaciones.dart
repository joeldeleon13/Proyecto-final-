// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Situation {
  final String id;
  final DateTime date;
  final String title;
  final String description;
  final String status;
  final String feedback;
  final String imageUrl;

  Situation({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.status,
    required this.feedback,
    required this.imageUrl,
  });
}

class MapaSituacionesPage extends StatelessWidget {
  const MapaSituacionesPage({super.key});

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
  const MySituationsPage({super.key});

  @override
  _MySituationsPageState createState() => _MySituationsPageState();
}

class _MySituationsPageState extends State<MySituationsPage> {
  List<Situation> situations = []; // Lista para almacenar las situaciones reportadas

  @override
  void initState() {
    super.initState();
    fetchSituations(); // Llama a la función para obtener las situaciones al iniciar la pantalla
  }

  Future<void> fetchSituations() async {
    final response = await http.get('https://adamix.net/defensa_civil/def/situaciones.php' as Uri);
    if (response.statusCode == 200) {
      // Parsea la respuesta JSON y actualiza la lista de situaciones
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        situations = data.map((situation) {
          return Situation(
            id: situation['id'],
            date: DateTime.parse(situation['date']),
            title: situation['title'],
            description: situation['description'],
            status: situation['status'],
            feedback: situation['feedback'],
            imageUrl: situation['imageUrl'],
          );
        }).toList();
      });
    } else {
      throw Exception('Failed to load situations');
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
            title: Text(situations[index].title),
            subtitle: Text('Reportado el ${situations[index].date.toString()}'),
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
            Text('Fecha: ${situation.date.toString()}'),
            Text('Título: ${situation.title}'),
            Text('Descripción: ${situation.description}'),
            // Aquí puedes mostrar más detalles como la imagen, estado, comentarios, etc.
          ],
        ),
      ),
    );
  }
}