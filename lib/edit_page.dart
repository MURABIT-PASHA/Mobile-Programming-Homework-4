import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework_4/contact_manager.dart';
import 'package:path_provider/path_provider.dart';

class EditPage extends StatefulWidget {
  final String contactInfo;
  const EditPage({Key? key, required this.contactInfo}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    Color activeColor = const Color(0xFF000000);
    Color nonactiveColor = const Color(0xFFADADAD);
    ContactManager contactManager = ContactManager();
    String newName = "";
    String newSurname = "";
    String newNumber = "";
    String name = widget.contactInfo.split(",")[0];
    String surname = widget.contactInfo.split(",")[1];
    String number = widget.contactInfo.split(",")[2];
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
                    newName = value;
                  },
                  decoration: InputDecoration(
                    hintText: widget.contactInfo.split(",")[0],
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
                    newSurname = value;
                  },
                  decoration: InputDecoration(
                    hintText: widget.contactInfo.split(",")[1],
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
                    newNumber = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: widget.contactInfo.split(",")[2],
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
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 70,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (newName == ""){
                            newName = name;
                          }
                          if (newSurname == ""){
                            newSurname = surname;
                          }
                          if (newNumber == ""){
                            newNumber = number;
                          }
                          if(await contactManager.editContact(newName, newSurname, newNumber, number)) {
                            print("Lokum güzeldir kundi");
                          }
                          else{
                            print("Error: Cannot added");
                          }

                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.green,
                            maximumSize: const Size(200, 50)),
                        child: const Text("Save")),
                    ElevatedButton(
                        onPressed: () async {
                            await contactManager.removeContact(number);
                            Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.red,
                            maximumSize: const Size(200, 50)),
                        child: const Text("Remove")),
                  ],
                ),
              )
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
