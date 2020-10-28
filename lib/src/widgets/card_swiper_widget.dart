import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSweper extends StatelessWidget {
  final List<Movie> movies;

  CardSweper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Swiper(
          itemWidth: _screenSize.width * 0.6,
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'),
                image: NetworkImage(movies[index].getPosterImg()),
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: movies.length,
          layout: SwiperLayout.STACK,
        ));
  }
}
