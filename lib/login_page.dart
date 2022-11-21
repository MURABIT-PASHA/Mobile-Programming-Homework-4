import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homework_4/registration_page.dart';
import 'package:path_provider/path_provider.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static String id = "login_id";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    String username = "";
    String password = "";
    int controlFlag = 0;
    Color activeColor = const Color(0xFF000000);
    Color nonactiveColor = const Color(0xFFADADAD);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "LOGIN",
          style:
              TextStyle(fontFamily: "Dongle", fontSize: 70, color: activeColor),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            Text(
              "Username",
              style: TextStyle(
                  fontFamily: "Dongle", fontSize: 30, color: activeColor),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 20,
              height: 40,
              child: TextField(
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(
                  hintText: "Type your username",
                  hintStyle: TextStyle(
                      fontFamily: "Dongle",
                      fontSize: 25,
                      color: nonactiveColor),
                  prefix: Icon(
                    Icons.person,
                    color: nonactiveColor,
                  ),
                ),
              ),
            ),
            Text(
              "Password",
              style: TextStyle(
                  fontFamily: "Dongle", fontSize: 30, color: activeColor),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 20,
              height: 40,
              child: TextField(
                onChanged: (value) {
                  password = value;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Type your password",
                  hintStyle: TextStyle(
                      fontFamily: "Dongle",
                      fontSize: 25,
                      color: nonactiveColor),
                  prefix: Icon(
                    Icons.lock,
                    color: nonactiveColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final file = await _localFile;
                if (await file.exists()) {
                  try {
                    file
                        .openRead()
                        .transform(utf8.decoder)
                        .transform(const LineSplitter())
                        .forEach((line) {
                      var user = line.toString().split(",");
                      if (user[0] == username && user[1] == password) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    HomePage(title: user[2])),(route)=>false);
                        controlFlag = 1;
                      }
                    });
                    if (controlFlag == 0) {
                      showDialog(
                          context: context,
                          builder: (builder) => const AlertDialog(
                                content: Text("User couldn't find"),
                              ));
                    }
                  } catch (exception) {
                    showDialog(
                        context: context,
                        builder: (builder) => const AlertDialog(
                              content: Text("Source couldn't find"),
                            ));
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (builder) => const AlertDialog(
                            content: Text("Source couldn't find"),
                          ));
                }
              },
              child: Container(
                  margin: const EdgeInsets.all(50),
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          colors: [Color(0xFF65D5E1), Color(0xFFE73EF9)])),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                        fontFamily: "Dongle",
                        fontSize: 30,
                        color: Colors.white),
                  )),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegistrationPage.id, (route) => false);
                },
                child: const Text(
                  "You don't have an account? Sign Up",
                  style: TextStyle(fontFamily: "Dongle", color: Colors.indigo),
                ))
          ],
        ),
      ),
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/users.txt');
  }
}
