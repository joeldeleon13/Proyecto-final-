import 'package:flutter/material.dart';

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
        title: Text('Inicio'),
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
                color:
                    _currentIndex == index ? Colors.blue : Colors.grey[400],
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
        color: Color(0xFF314F66),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF18355F),
              ),
              child: Center(
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            buildListTile(Icons.library_books, 'Historia', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => HistoriaPage()));
            }),
            buildListTile(Icons.build, 'Servicios', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ServiciosPage()));
            }),
            buildListTile(Icons.article, 'Noticias', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => NoticiasPage()));
            }),
            buildListTile(Icons.video_library, 'Videos', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideosPage()));
            }),
            buildListTile(Icons.house, 'Albergues', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => AlberguesPage()));
            }),
            buildListTile(Icons.map, 'Mapa de Albergues', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapaAlberguesPage()));
            }),
            buildListTile(Icons.warning, 'Medidas Preventivas', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => MedidasPreventivasPage()));
            }),
            buildListTile(Icons.people, 'Miembros', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => MiembrosPage()));
            }),
            buildListTile(Icons.volunteer_activism, 'Quiero ser Voluntario', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => QuieroSerVoluntarioPage()));
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
        title: Text('Servicios'),
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
        title: Text('Noticias'),
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
        title: Text('Videos'),
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
        title: Text('Albergues'),
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
        title: Text('Mapa de Albergues'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medidas Preventivas'),
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
        child: Text('Página de Medidas Preventivas'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class MiembrosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Miembros'),
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
        child: Text('Página de Miembros'),
      ),
      drawer: DrawerMenu(),
    );
  }
}

class QuieroSerVoluntarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiero ser Voluntario'),
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
        child: Text('Página de Quiero ser Voluntario'),
      ),
      drawer: DrawerMenu(),
    );
  }
}
