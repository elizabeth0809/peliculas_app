import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';
import '../search/search_delegate.dart';
import '../widgets/widgets.dart';

class HomeScrenn extends StatelessWidget {
  const HomeScrenn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    print(moviesProvider.onDisplayMovies);
    return Scaffold(
        appBar: AppBar(
          title: Text('peliculas'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: MovieSearchDelegate()),
                icon: Icon(Icons.search_sharp)),
          ],
        ),
        body: SingleChildScrollView(
          /**esto es para poder hacer scroll si se desborda */
          child: Column(
            children: [
              //tarjetas principales
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              //listado de peliculas
              MovieSlier(
                movies: moviesProvider.popularMovies,
                title: 'Populares!',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        ));
  }
}
