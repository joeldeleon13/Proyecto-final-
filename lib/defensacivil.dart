// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'services/mi_Situaciones.dart';
import 'services/reports.dart';
import 'services/services.dart';
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
                  MaterialPageRoute(builder: (context) => const ServiciosPage()));
            }),
            buildListTile(Icons.article, 'Noticias', () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoticiasPage()));
            }),
            buildListTile(Icons.article, 'Noticias Específicas', () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoticiasEspecificasPage()));
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
                      builder: (context) => const ReportarSituacionPage(token: '',)));
            }),
            buildListTile(Icons.history, 'Mis Situaciones', () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MySituationsPage()));
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
        title: Text('Historia'),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Historia de la Defensa Civil',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'La Defensa Civil es una organización dedicada a proteger a la población y los recursos frente a desastres naturales, crisis y emergencias. Su origen se remonta a la Segunda Guerra Mundial, cuando surgió la necesidad de proteger a los civiles de los bombardeos y ataques enemigos. En muchos países, la experiencia de la guerra impulsó la creación de sistemas formales de Defensa Civil.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Desde sus comienzos, la Defensa Civil ha evolucionado en respuesta a una variedad de amenazas, tanto naturales como provocadas por el hombre. A lo largo de los años, se ha convertido en una institución multifacética que aborda una amplia gama de situaciones de emergencia, incluyendo terremotos, huracanes, inundaciones, incendios forestales, accidentes industriales, ataques terroristas y pandemias.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Los principales objetivos de la Defensa Civil son la prevención, preparación, respuesta y recuperación ante desastres. Esto implica la implementación de medidas preventivas, la planificación de emergencias, la capacitación de la población en primeros auxilios y evacuación, la coordinación de operaciones de rescate y la asistencia en la fase de recuperación y reconstrucción.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'A lo largo de su historia, la Defensa Civil ha logrado numerosos avances y hitos significativos. Estos incluyen el desarrollo de sistemas de alerta temprana, la creación de protocolos de respuesta ante emergencias, la adopción de tecnologías avanzadas para la gestión de desastres y la colaboración internacional en materia de ayuda humanitaria.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
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
        title: Text('Noticias'),
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
      body: FutureBuilder(
        future: _fetchNoticias(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, String>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar las noticias'));
          } else {
            final noticias = snapshot.data!;
            return ListView.builder(
              itemCount: noticias.length,
              itemBuilder: (BuildContext context, int index) {
                final noticia = noticias[index];
                return ListTile(
                  title: Text(noticia['titulo']!),
                  subtitle: Text(noticia['contenido']!),
                  // Puedes agregar aquí la lógica para mostrar la imagen si lo deseas
                  // Ejemplo: Image.network(noticia['foto']!),
                );
              },
            );
          }
        },
      ),
      drawer: DrawerMenu(),
    );
  }

  Future<List<Map<String, String>>> _fetchNoticias() async {
    final String apiUrl = 'https://adamix.net/defensa_civil/def/noticias.php';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> noticiasData = data['datos'];

      // Lista donde se almacenarán las noticias con los tipos adecuados
      List<Map<String, String>> noticias = [];

      // Iterar sobre cada noticia y convertirla al tipo correcto
      noticiasData.forEach((noticia) {
        noticias.add({
          'titulo': noticia['titulo'],
          'contenido': noticia['contenido'],
          'foto': noticia['foto'],
        });
      });

      return noticias;
    } else {
      throw Exception('Failed to load noticias');
    }
  }
}

class NoticiasEspecificasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoticiasEspecificas '),
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
        child: Text('Página de NoticiasEspecificas'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  late List<dynamic> _videos = [];

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    final apiUrl = 'https://adamix.net/defensa_civil/def/videos.php';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      setState(() {
        _videos = json.decode(response.body)['datos'];
      });
    } else {
      throw Exception('Failed to load videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
      ),
      body: _videos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                final video = _videos[index];
                return ListTile(
                  title: Text(video['titulo']),
                  subtitle: Text(video['descripcion']),
                  onTap: () {
                    _playYoutubeVideo(video['link']);
                  },
                );
              },
            ),
    );
  }

  void _playYoutubeVideo(String videoId) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Video Player'),
          ),
          body: Center(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class AlberguesPage extends StatefulWidget {
  @override
  _AlberguesPageState createState() => _AlberguesPageState();
}

class _AlberguesPageState extends State<AlberguesPage> {
  late List<dynamic> _albergues;
  late List<dynamic> _filteredAlbergues;
  TextEditingController _searchController = TextEditingController();

  @override
void initState() {
  super.initState();
  _albergues = [];
  _filteredAlbergues = [];
  _fetchAlbergues();
}

  Future<void> _fetchAlbergues() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> alberguesData = data['datos'];
      setState(() {
        _albergues = alberguesData;
        _filteredAlbergues = _albergues;
      });
    } else {
      throw Exception('Failed to load albergues');
    }
  }

  void _filterAlbergues(String query) {
    setState(() {
      _filteredAlbergues = _albergues.where((albergue) {
        final ciudad = albergue['ciudad'].toString().toLowerCase();
        return ciudad.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albergues'),
        backgroundColor: Color.fromARGB(255, 231, 141, 6),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _filterAlbergues(value),
              decoration: InputDecoration(
                labelText: 'Buscar por ciudad',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredAlbergues.length,
              itemBuilder: (context, index) {
                final albergue = _filteredAlbergues[index];
                return ListTile(
                  title: Text(albergue['ciudad']),
                  subtitle: Text(albergue['edificio']),
                  onTap: () {
                    // Acción al seleccionar un albergue
                  },
                );
              },
            ),
          ),
        ],
      ),
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
