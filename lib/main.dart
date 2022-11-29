import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviewatcher/Components/CustomVideoPlayer.dart';
import 'package:moviewatcher/Components/MovieCard.dart';
import 'package:moviewatcher/Pages/SettingsPage.dart';
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
        debugShowCheckedModeBanner: false,
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
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Image.network(
              'https://hdqwalls.com/wallpapers/movie-wall-e-ad.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                  child: const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 30,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Movie Watcher",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: 600,
                      child: FutureBuilder(
                        future: MyDatabase().getMovies(),
                        builder:
                            ((context, AsyncSnapshot<List<MovieModel>> snap) {
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
            ),
          ],
        ),
      ),
    );
  }
}
