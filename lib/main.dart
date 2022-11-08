import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviewatcher/Components/CustomVideoPlayer.dart';
import 'package:moviewatcher/Components/MovieCard.dart';
import 'package:moviewatcher/Services/Database.dart';
import 'package:video_player/video_player.dart';

import 'Models/MovieModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent()
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    MyDatabase().SetUpmovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 56, 55, 55),
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Movie Watcher",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 56, 55, 55),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: 300,
                  child: FutureBuilder(
                    future: MyDatabase().getMovies(),
                    builder: ((context, AsyncSnapshot<List<MovieModel>> snap) {
                      if (snap.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snap.data!.length,
                            itemBuilder: (context, index) {
                              return MovieCard(snap.data![index]);
                            });
                      } else {
                        return Text("Loading");
                      }
                    }),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
