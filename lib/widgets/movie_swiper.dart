import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlier extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlier(
      {Key? key, required this.movies, this.title, required this.onNextPage})
      : super(key: key);

  @override
  State<MovieSlier> createState() => _MovieSlierState();
}

class _MovieSlierState extends State<MovieSlier> {
  //esto permite crear una listView en el initstate
  final ScrollController scrollController = new ScrollController();
  //esto ejecuta est codigo al inicar
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      //esto me señala la posicion actual del scroll
      /*print(scrollController.position.pixels);
      //esto muestra la posicion en el ultimo scroll
      print(scrollController.position.maxScrollExtent);*/
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
        //print('Obtener siguiente pagina');
      }
    });
  }

  //esto destruye lo contriudo
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //aqui si el valor es no es nulo se ejecuta
          if (this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(this.widget.title!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          Expanded(
              //este es el padre el cual agarra todo el ancho del container

              child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.movies.length,
                  itemBuilder: (_, int index) => _MoviePoster(
                      widget.movies[index],
                      '${widget.title}-${index}-${widget.movies[index].id}')))
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;
//aqui se recibe la movie
  const _MoviePoster(this.movie, this.heroId);
  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return Container(
      width: 130,
      height: 290,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/hola.png'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            movie.title,
            maxLines: 2,
            /*Esto pone el texto en 2 lineas */
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
