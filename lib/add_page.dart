import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
    int controlFlag = 0;
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
                    controlFlag = 0;
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
                    final file = await _localFile;
                    if (!await file.exists()) {
                      file.create();
                    }
                      var sinkR = file.openRead();
                      var sinkW = file.openWrite(mode: FileMode.append);
                      await sinkR
                          .transform(utf8.decoder)
                          .transform(const LineSplitter())
                          .forEach((line) {
                        if (line.split(",")[2] == number) {
                          showDialog(
                              context: context,
                              builder: (builder) => const AlertDialog(
                                    content: Text("Already have a contact"),
                                  ));
                          controlFlag = 1;
                        }
                      });
                      if (controlFlag == 0) {
                        sinkW.write("$name,$surname,$number\n");
                        sinkW.close();
                        setState(() {
                          Navigator.pop(context);
                        });
                      }
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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/contacts.txt');
  }
}
