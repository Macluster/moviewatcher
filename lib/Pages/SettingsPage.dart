import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var ipadress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          const Text(
            "Set IP Adress",
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(
            height: 200,
          ),
          Container(
            width: 500,
            child: TextField(
              controller: ipadress,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.setString("ip", ipadress.text);
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text("Set"),
            ),
          )
        ]),
      ),
    );
  }
}
