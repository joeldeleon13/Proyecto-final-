import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Image.asset(
                'assets/acciones.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            ActionSlider(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'La Defensa Civil es una organización encargada de prevenir y mitigar desastres naturales y situaciones de emergencia. Sus acciones principales incluyen la planificación, prevención, educación, asistencia y recuperación.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class ActionSlider extends StatefulWidget {
  @override
  _ActionSliderState createState() => _ActionSliderState();
}

class _ActionSliderState extends State<ActionSlider> {
  final List<String> actions = [
    'Planificación',
    'Prevención',
    'Educación',
    'Asistencia',
    'Recuperación'
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Acciones Importantes de la Defensa Civil',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Container(
          height: 200,
          child: PageView.builder(
            itemCount: actions.length,
            controller: PageController(viewportFraction: 0.8),
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return actionCard(actions[index]);
            },
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: actions.map((action) {
            int index = actions.indexOf(action);
            return Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blue : Colors.grey[400],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget actionCard(String action) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.orange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              action,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF314F66), // Color de fondo del contenedor
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF18355F), // Color de fondo del encabezado
                image: DecorationImage(
                  image: AssetImage(
                      'assets/defensa.png'), // Ruta de la imagen en tus assets
                  fit: BoxFit
                      .cover, // Esto hará que la imagen cubra todo el espacio
                ),
              ),
              child: null,
            ),
            buildListTile(Icons.home, 'Inicio', () {
              Navigator.pop(context); // Cerrar el DrawerMenu
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomePage())); // Regresar a la página de inicio
            }),
            buildListTile(Icons.library_books, 'Historia', () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoriaPage()));
            }),
            buildListTile(Icons.build, 'Servicios', () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ServiciosPage()));
            }),
            buildListTile(Icons.article, 'Noticias', () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoticiasPage()));
            }),
            buildListTile(Icons.video_library, 'Videos', () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VideosPage()));
            }),
            buildListTile(Icons.house, 'Albergues', () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AlberguesPage()));
            }),
            buildListTile(Icons.map, 'Mapa de Albergues', () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MapaAlberguesPage()));
            }),
            buildListTile(Icons.warning, 'Medidas Preventivas', () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MedidasPreventivasPage()));
            }),
            buildListTile(Icons.people, 'Miembros', () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MiembrosPage()));
            }),
            buildListTile(Icons.volunteer_activism, 'Quiero ser Voluntario',
                () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuieroSerVoluntarioPage()));
            }),
            buildListTile(Icons.report, 'Reportar Situación', () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReportarSituacionPage()));
            }),
            buildListTile(Icons.history, 'Mis Situaciones', () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MisSituacionesPage()));
            }),
            buildListTile(Icons.map_outlined, 'Mapa de Situaciones', () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapaSituacionesPage()));
            }),
            buildListTile(Icons.info, 'Acerca de', () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutPage()));
            }),

            // Añadir el ListTile para salir
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: Text(
                'Salir',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navegar a la página de inicio (HomePage)
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}

// Clase de cada página (sin cambios)

class HistoriaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historia '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text('Página de Historia'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class ServiciosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Servicios '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text('Página de Servicios'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class NoticiasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text('Página de Noticias'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class VideosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text('Página de Videos'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class AlberguesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albergues '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text('Página de Albergues'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class MapaAlberguesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MapaAlbergues '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text('Página de Mapa de Albergues'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class MedidasPreventivasPage extends StatelessWidget {
  Future<List<MedidaPreventiva>> fetchMedidasPreventivas() async {
    final response = await http.get(Uri.parse(
        'https://adamix.net/defensa_civil/def/medidas_preventivas.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['datos'];
      return data.map((item) => MedidaPreventiva.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medidas Preventivas'),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
      ),
      body: FutureBuilder<List<MedidaPreventiva>>(
        future: fetchMedidasPreventivas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return MedidaPreventivaCard(snapshot.data![index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      drawer: DrawerMenu(),
    );
  }
}

class MedidaPreventiva {
  final String id;
  final String titulo;
  final String descripcion;
  final String foto;

  MedidaPreventiva({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.foto,
  });

  factory MedidaPreventiva.fromJson(Map<String, dynamic> json) {
    return MedidaPreventiva(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      foto: json['foto'],
    );
  }
}

class MedidaPreventivaCard extends StatelessWidget {
  final MedidaPreventiva medidaPreventiva;

  MedidaPreventivaCard(this.medidaPreventiva);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.network(
            medidaPreventiva.foto,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              medidaPreventiva.titulo,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              medidaPreventiva.descripcion,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MiembrosPage extends StatefulWidget {
  @override
  _MiembrosPageState createState() => _MiembrosPageState();
}

class _MiembrosPageState extends State<MiembrosPage> {
  List<dynamic> miembros = []; // Lista para almacenar los datos de los miembros

  // Método para obtener los datos de la API al iniciar la página
  Future<void> _fetchMiembros() async {
    final String apiUrl = 'https://adamix.net/defensa_civil/def/miembros.php';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final bool success = responseData['exito'];

        if (success) {
          setState(() {
            miembros = responseData['datos'];
          });
        } else {
          _showErrorDialog(context, responseData['mensaje']);
        }
      } else {
        _showErrorDialog(
            context, 'Hubo un problema al intentar conectarse al servidor.');
      }
    } catch (e) {
      _showErrorDialog(context, 'Hubo un error inesperado.');
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchMiembros(); // Llamar al método para obtener los datos al iniciar la página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Miembros '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: miembros.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Mostrar un indicador de carga mientras se obtienen los datos
          : ListView.builder(
              itemCount: miembros.length,
              itemBuilder: (context, index) {
                final miembro = miembros[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(miembro['foto']),
                  ),
                  title: Text(miembro['nombre']),
                  subtitle: Text(miembro['cargo']),
                );
              },
            ),
      drawer: DrawerMenu(),
    );
  }
}

class QuieroSerVoluntarioPage extends StatefulWidget {
  @override
  _QuieroSerVoluntarioPageState createState() =>
      _QuieroSerVoluntarioPageState();
}

class _QuieroSerVoluntarioPageState extends State<QuieroSerVoluntarioPage> {
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController claveController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  Future<void> _registrar(BuildContext context) async {
    final String apiUrl = 'https://adamix.net/defensa_civil/def/registro.php';
    final String cedula = cedulaController.text;
    final String nombre = nombreController.text;
    final String apellido = apellidoController.text;
    final String clave = claveController.text;
    final String correo = correoController.text;
    final String telefono = telefonoController.text;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'cedula': cedula,
          'nombre': nombre,
          'apellido': apellido,
          'clave': clave,
          'correo': correo,
          'telefono': telefono,
        },
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      final bool success = responseData['exito'];

      if (success) {
        // Mostrar mensaje de éxito y redirigir a otra página, por ejemplo, la página de inicio
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registro exitoso')));
        Navigator.pop(
            context); // Volver a la página anterior después del registro exitoso
      } else {
        _showErrorDialog(context, responseData['mensaje']);
      }
    } catch (e) {
      _showErrorDialog(context, 'Hubo un error inesperado.');
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiero ser Voluntario '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: cedulaController,
              decoration: InputDecoration(labelText: 'Cédula'),
            ),
            TextFormField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextFormField(
              controller: apellidoController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextFormField(
              controller: claveController,
              decoration: InputDecoration(labelText: 'Clave'),
              obscureText: true,
            ),
            TextFormField(
              controller: correoController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextFormField(
              controller: telefonoController,
              decoration: InputDecoration(labelText: 'Teléfono'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _registrar(context);
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class ReportarSituacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportar Situaciones '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text('Página para reportar situaciones de emergencia'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class MisSituacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Situaciones '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text(
            'Página para visualizar el historial de situaciones reportadas'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class MapaSituacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Situaciones '),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text(
            'Página para visualizar el mapa interactivo de situaciones reportadas'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
      ),
      body: ListView(
        children: <Widget>[
          DeveloperCard(
            name: 'Jorgenis Belen',
            role: '2022-0445',
            photoUrl: 'assets/yo.jpeg',
          ),
          DeveloperCard(
            name: 'Joel De León reyes',
            role: '2022-0622',
            photoUrl: 'assets/joel.jpeg',
          ),
          DeveloperCard(
            name: 'José Andrés Trinidad ',
            role: '2022-0575',
            photoUrl: 'assets/jose.jpg',
          ),
          DeveloperCard(
            name: 'Deuris Andres Estevez Bueno',
            role: '2022-0233',
            photoUrl: 'assets/deuris.jpeg',
          ),
        ],
      ),
    );
  }
}

class DeveloperCard extends StatelessWidget {
  final String name;
  final String role;
  final String photoUrl;

  const DeveloperCard({
    Key? key,
    required this.name,
    required this.role,
    required this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Container(
        height: 200, // Tamaño deseado para todas las fotos
        width: 200, // Tamaño deseado para todas las fotos
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset(
                photoUrl,
                fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              role,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16.0),
            // Aquí puedes agregar más información sobre el desarrollador si es necesario
          ],
        ),
      ),
    );
  }
}
