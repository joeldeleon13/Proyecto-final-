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
  final _latitudController = TextEditingController();
  final _longitudController = TextEditingController();

  String _nombreCompleto = "";

  void _mostrarMapa() {
    final ubicacionMarcador = LatLng(18.4861, -69.9312); // Coordenadas de Santo Domingo

    setState(() {
      _nombreCompleto = "${_nombreController.text} ${_apellidoController.text}";
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapaPage(
          ubicacionMarcador: ubicacionMarcador,
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
                TextFormField(
                  controller: _latitudController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Latitud',
                  ),
                ),
                TextFormField(
                  controller: _longitudController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Longitud',
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
  final LatLng ubicacionMarcador;
  final String nombreCompleto;

  const MapaPage({
    required this.ubicacionMarcador,
    required this.nombreCompleto,
  });

   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: ubicacionMarcador, 
          zoom: 10.0,
        ), 
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ), 
          MarkerLayer(markers: [
            Marker(
              width: 60.0,
              height: 60.0,
              point: ubicacionMarcador, 
              child: 
              Icon(
                Icons.person_pin, 
                size: 50,
                color: Color.fromARGB(255, 244, 54, 54),
              ))
          ])
        ]
        ),
    );
  }
}
