import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tarea 9 y 10',
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();

  String _nombreCompleto = "";

  void _mostrarMapa() {
  final ubicaciones = [
    LatLng(18.4861, -69.9312), // Santo Domingo
    LatLng(19.7902, -70.6902), // Puerto Plata
    LatLng(18.8075, -71.2290), // San Juan
    LatLng(18.9424, -70.4093), // Bonao
    LatLng(19.4500, -70.6667), // Santiago
  ];

  setState(() {
    _nombreCompleto = "${_nombreController.text} ${_apellidoController.text}";
  });

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MapaPage(
        ubicaciones: ubicaciones,
        nombreCompleto: _nombreCompleto,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicación con Marcador'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                TextFormField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(
                    labelText: 'Apellido',
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _mostrarMapa();
                    }
                  },
                  child: const Text('Siguiente'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MapaPage extends StatelessWidget {
  final List<LatLng> ubicaciones;
  final String nombreCompleto;

  const MapaPage({
    required this.ubicaciones,
    required this.nombreCompleto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: ubicaciones.first, // Centramos el mapa en la primera ubicación
          zoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: [
            for (final ubicacion in ubicaciones)
              Marker(
                width: 60.0,
                height: 60.0,
                point: ubicacion,
                child: Icon(
                  Icons.person_pin,
                  size: 50,
                  color: Colors.red, // Puedes cambiar el color del marcador si lo deseas
                ),
              ),
          ]),
        ],
      ),
    );
  }
}
