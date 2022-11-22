import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  static String id = "add_id";
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    Color activeColor = const Color(0xFF000000);
    Color nonactiveColor = const Color(0xFFADADAD);
    String name = "";
    String surname = "";
    String number = "";
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
          child: ListView(
            children: [
              Text(
                "Name",
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
                    name = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Type your contact name",
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
                "Surname",
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
                    surname = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Type your contact surname",
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
                "Number",
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
                    number = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Type your contact phone number",
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
              ElevatedButton(
                  onPressed: () async {
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.green,
                      maximumSize: const Size(200, 50)),
                  child: const Text("Add"))
            ],
          ),
        ),
      ),
    );
  }
}
