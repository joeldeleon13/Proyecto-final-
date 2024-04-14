import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


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
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
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