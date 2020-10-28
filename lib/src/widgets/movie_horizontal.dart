import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:flutter/cupertino.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage});
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 100) {
        nextPage();
      }
    });
    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return _card(context, movies[index]);
        },
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    final card = Container(
      margin: EdgeInsets.only(left: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FadeInImage(
              image: NetworkImage(movie.getPosterImg()),
              placeholder: AssetImage('assets/img/loading.gif'),
              fit: BoxFit.cover,
              height: 140.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
      child: card,
    );
  }

  // List<Widget> _cards(BuildContext context) {
  //   return movies.map((movie) {
  //     return Container(
  //       margin: EdgeInsets.only(right: 15.0),
  //       child: Column(
  //         children: <Widget>[
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(8.0),
  //             child: FadeInImage(
  //               image: NetworkImage(movie.getPosterImg()),
  //               placeholder: AssetImage('assets/img/loading.gif'),
  //               fit: BoxFit.cover,
  //               height: 100.0,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 5.0,
  //           ),
  //           Text(
  //             movie.title,
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }
}
