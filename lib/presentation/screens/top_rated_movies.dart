import 'package:flutter/material.dart';
import 'package:seminario_flutter/presentation/bloc_state.dart';
import 'package:seminario_flutter/presentation/movies_bloc.dart';

import '../../domain/entities/movie.dart';
import '../widgets/movie_card.dart';

class TopRatedMovies extends StatefulWidget {
  const TopRatedMovies({super.key, required this.moviesBloc});

  final MoviesBloc moviesBloc;

  @override
  State<TopRatedMovies> createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  @override
  void initState() {
    super.initState();
    widget.moviesBloc.initialize();
    widget.moviesBloc.getTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Top Rated Movies')),
        body: StreamBuilder(
          stream: widget.moviesBloc.moviesStream,
          builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot) {
            if (snapshot.hasData) {
              final state = snapshot.data;
              if (state is ErrorBlocState) {
                return Text('Error');
              } else if (state is LoadingBlocState) {
                return CircularProgressIndicator();
              } else if (state is SuccessBlocState) {
                final successResult =
                    (state as SuccessBlocState<List<Movie>>).result;
                final gridMovies = <Widget>[];
                for (Movie movie in successResult) {
                  gridMovies.add(MovieCard(movie: movie));
                }
                if (width > 720) {
                  return GridView.count(
                    crossAxisCount: 5,
                    childAspectRatio: 0.50,
                    children: gridMovies,
                  );
                } else {
                  return GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.50,
                    children: gridMovies,
                  );
                }
              } else if (state is EmptyBlocState) {
                return Text('There is no data');
              } else {
                return Text('Unspecific error');
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
