import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:securebox/settings.dart';

void main() {
  runApp(MaterialApp(home: MainScreen(), title: "SecureBox"));
}

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String status = "Locked";
  var lock_symbol = Icons.lock_outline;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            top: 50,
            child: Text(status,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        Positioned(
            top: 100,
            child: IconButton(
              onPressed: () {
                setState(() async {
                  if (status == "Locked") {
                    await Dio()
                        .get("http://192.168.43.116/securebox?status=open");
                    status = "Unlocked";
                    lock_symbol = Icons.lock_open_outlined;
                  } else {
                    await Dio()
                        .get("http://192.168.43.116/securebox?status=close");
                    status = "Locked";
                    lock_symbol = Icons.lock_outline;
                  }
                });
              },
              icon: Icon(lock_symbol),
            )),
        Positioned(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () => print("log"), icon: Icon(Icons.history)),
            IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingScreen())),
                icon: Icon(Icons.settings_outlined)),
          ],
        ))
      ],
    ));
  }
}
