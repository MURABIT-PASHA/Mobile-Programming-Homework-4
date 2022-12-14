import 'package:flutter/material.dart';
import 'package:homework_4/login_page.dart';
import 'package:homework_4/user_manager.dart';

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
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    String username = "";
    String password = "";
    String name = "";
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
              "Name",
              style: TextStyle(fontFamily: "Dongle", fontSize: 30, color: activeColor),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 20,
              height: 40,
              child: TextField(
                controller: nameController,
                onChanged: (value){
                  name = value;
                },
                decoration: InputDecoration(
                  hintText: "Type your name",
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
              "Username",
              style: TextStyle(fontFamily: "Dongle", fontSize: 30, color: activeColor),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 20,
              height: 40,
              child: TextField(
                controller: usernameController,
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
                controller: passwordController,
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
              onTap: () async{
                UserManager userManager = UserManager();
                if(await userManager.addUser(username, password, name)){
                  Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
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
