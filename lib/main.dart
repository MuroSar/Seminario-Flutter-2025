import 'package:flutter/material.dart';
import 'package:seminario_flutter/counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder(
                stream: _counterBloc.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  final state = snapshot.data;

                  switch (state.runtimeType) {
                    case ErrorBlocState:
                      return Text('There was an error');
                    case LoadingBlocState:
                      return CircularProgressIndicator();
                    case SuccessBlocState:
                      return Text('${state.counterValue}');
                    case EmptyBlocState:
                      return Text('It is empty');
                    default:
                      return Text('Default');
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                  onPressed: _counterBloc.incrementCounter,
                  child: Text('Increment counter'),
                ),
                FilledButton(
                  onPressed: _counterBloc.throwError,
                  child: Text('Error'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
