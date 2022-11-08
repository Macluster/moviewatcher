import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviewatcher/Components/CustomVideoPlayer.dart';
import 'package:moviewatcher/Models/MovieModel.dart';

class ShowMoviePage extends StatefulWidget {
  MovieModel model;
  ShowMoviePage(this.model);
  @override
  State<ShowMoviePage> createState() => _ShowMoviePageState();
}

class _ShowMoviePageState extends State<ShowMoviePage> {
  @override
  Widget build(BuildContext context) {
    backButtonPressed() {}

    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  flex: 5, child: CustomVideoPlayer(widget.model.movieLink))
            ],
          ),
        ),
      ),
    );
  }
}
