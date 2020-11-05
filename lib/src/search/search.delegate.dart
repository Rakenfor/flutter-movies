import 'package:flutter/material.dart';
import 'package:movies/src/models/movie.model.dart';
import 'package:movies/src/providers/movies.providers.dart';

class Search extends SearchDelegate {
  String selection = '';
  final moviesProvider = new MoviesProvider();

  final movies = [
    'Spiderman',
    'Flash',
    'Liga de la gusticia',
    'Aquaman',
    'Batman',
    'Shazam'
  ];
  final moviesultimate = ['Aquaman', 'Linterna verde'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crear los  resultados que se mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.purpleAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;

          return ListView(
            children: movies.map((movie) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FadeInImage(
                    image: NetworkImage(movie.getPosterImg()),
                    placeholder: AssetImage('assets/img/loading.gif'),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () {
                  close(context, null);
                  movie.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: movie);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias cuando la presona escribe

  //   final listSugerida = (query.isEmpty)
  //       ? moviesultimate
  //       : movies
  //           .where((element) =>
  //               element.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList();

  //   return ListView.builder(
  //     itemCount: listSugerida.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(
  //           listSugerida[i],
  //         ),
  //         onTap: () => {
  //           selection = listSugerida[i],
  //           showResults(context),
  //         },
  //       );
  //     },
  //   );
  // }
}
