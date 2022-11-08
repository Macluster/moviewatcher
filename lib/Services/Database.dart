import 'dart:convert';

import 'package:moviewatcher/Models/MovieModel.dart';
import 'package:http/http.dart' as http;
import '../Config/config.dart';

class MyDatabase {
  SetUpmovies() async {
    var result = await http.post(
        Uri.parse(
            'http://192.168.1.55/moviewatcher/moviewatcher/Server/SetupFolders.php'),
        body: {},
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    print(result);
  }

  Future<List<MovieModel>> getMovies() async {
    MovieModel model = MovieModel(1, "", "", " ", "");
    List<MovieModel> list = [];

    var result = await http.post(
        Uri.parse(
            'http://192.168.1.55/moviewatcher/moviewatcher/Server/GetMovies.php'),
        body: {},
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    print(result);

    // print("http request =" + result.body);
    //  print("map bval ${locMap['lat']}");
    var map = json.decode(result.body);
    // print(map);
    map.forEach((value) {
      print(value);

      model = MovieModel(int.parse(value["movieId"]), value["movieName"],
          value["movieGenre"], value["movieLanguage"], value["movieLink"]);
      list.add(model);
    });

    return list;
  }
}
