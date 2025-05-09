import 'package:flutter/material.dart';
import 'package:seminario_flutter/presentation/characters_bloc.dart';

import '../../domain/entities/character.dart';
import '../../domain/entities/movie.dart';
import '../bloc_state.dart';

class PopularCharacters extends StatefulWidget {
  const PopularCharacters({super.key, required this.charactersBloc});

  final CharactersBloc charactersBloc;

  @override
  State<PopularCharacters> createState() => _PopularCharactersState();
}

class _PopularCharactersState extends State<PopularCharacters> {
  @override
  void initState() {
    super.initState();
    widget.charactersBloc.initialize();
    widget.charactersBloc.getPopularCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Popular Characters')),
        body: StreamBuilder(
          stream: widget.charactersBloc.charactersStream,
          builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot) {
            if (snapshot.hasData) {
              final state = snapshot.data;
              if (state is ErrorBlocState) {
                return Text('Error');
              } else if (state is LoadingBlocState) {
                return CircularProgressIndicator();
              } else if (state is SuccessBlocState) {
                final successResult =
                    (state as SuccessBlocState<List<Character>>).result;
                if (width > 480) {
                  return ListView.builder(
                    itemCount: successResult.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(characters: successResult[index]);
                    },
                    scrollDirection: Axis.horizontal,
                  );
                } else {
                  return ListView.builder(
                    itemCount: successResult.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(characters: successResult[index]);
                    },
                    scrollDirection: Axis.horizontal,
                  );
                }
              } else if (state is EmptyBlocState) {
                return Text('There is no data');
              } else {
                return Text('Error');
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

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.characters, this.radius = 4.0});

  final Character characters;
  final double radius;

  List<Widget> buildWidgetList() {
    final widgetList = <Widget>[];
    for (Movie movie in characters.knownFor!) {
      if (movie.title != null) {
        widgetList.add(Text(movie.title!));
      }
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(characters.fullProfilePath, fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                characters.name ?? '-',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Column(
              children: [
                Text(
                  'Also known for',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...buildWidgetList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
