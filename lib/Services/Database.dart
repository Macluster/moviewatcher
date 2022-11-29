import 'dart:convert';

import 'package:moviewatcher/Models/MovieModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Config/config.dart';

class MyDatabase {
  String ipAdress = "";

  MyDatabase() {}

  SetUpmovies() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ipAdress = pref.getString('ip') ?? "192.168.1.55";
    print("ipaddress is" + ipAdress);
    var result = await http.post(
        Uri.parse('http://$ipAdress/moviewatcher/Server/SetupFolders.php'),
        body: {},
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    print(result);
  }

  Future<List<MovieModel>> getMovies() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ipAdress = pref.getString('ip') ?? "192.168.1.55";
    MovieModel model = MovieModel(1, "", "", " ", "");
    List<MovieModel> list = [];

    var result = await http.post(
        Uri.parse('http://$ipAdress/moviewatcher/Server/GetMovies.php'),
        body: {},
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    print(result.body);

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
