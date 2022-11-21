import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  static String id = "register_id";
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    Color activeColor = const Color(0xFF000000);
    Color nonactiveColor = const Color(0xFFADADAD);
    String username = "";
    String password = "";
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("SIGN UP", style: TextStyle(fontFamily: "Dongle", fontSize: 70, color: activeColor),),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            Text(
              "Username",
              style: TextStyle(fontFamily: "Dongle", fontSize: 30, color: activeColor),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 20,
              height: 40,
              child: TextField(
                onChanged: (value){
                  username = value;
                },
                decoration: InputDecoration(
                  hintText: "Type your username",
                  hintStyle:
                  TextStyle(fontFamily: "Dongle", fontSize: 25, color: nonactiveColor),
                  prefix: Icon(
                    Icons.person,
                    color: nonactiveColor,
                  ),
                ),
              ),
            ),
            Text(
              "Password",
              style: TextStyle(fontFamily: "Dongle", fontSize: 30, color: activeColor),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 20,
              height: 40,
              child: TextField(
                onChanged: (value){
                  password = value;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Type your password",
                  hintStyle:
                  TextStyle(fontFamily: "Dongle", fontSize: 25, color: nonactiveColor),
                  prefix: Icon(
                    Icons.lock,
                    color: nonactiveColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
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
                    "SIGN UP",
                    style: TextStyle(fontFamily: "Dongle", fontSize: 30, color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
