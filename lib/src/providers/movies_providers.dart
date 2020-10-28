import 'dart:async';

import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Movies {
  String _apiKey = 'a445bc700c8584bb09a0f7397375eaf8';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _charging = false;

  List<Movie> _populares = new List();

  //Creando un stream
  //SI se pone sin el broscat solo se puede usar un hilo
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularesSink => _popularsStreamController.sink.add;
  Stream<List<Movie>> get populatesStrem => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }
  //Fin del stream

  Future<List<Movie>> _processResponse(Uri url) async {
    final resp = await http.get(url);

    final decodeData = json.decode(resp.body);

    final movies = MoviesList.fromJsonList(decodeData['results']);

    return movies.items;
  }

  Future<List<Movie>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_charging) return [];

    _charging = true;
    _popularesPage++;

    print('Cargango siguientes...');
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _processResponse(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _charging = false;
    return resp;
  }
}
