import 'package:flutter/material.dart';
import 'package:seminario_flutter/presentation/bloc_state.dart';
import 'package:seminario_flutter/presentation/movies_bloc.dart';

import '../../domain/entities/movie.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({super.key, required this.moviesBloc});

  final MoviesBloc moviesBloc;

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  @override
  void initState() {
    super.initState();
    widget.moviesBloc.initialize();
    widget.moviesBloc.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Popular Movies')),
        body: StreamBuilder<BlocState>(
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
                return ListView.builder(
                  itemCount: successResult.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(successResult[index].title ?? '-'),
                    );
                  },
                );
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
