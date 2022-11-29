import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework_4/contact_manager.dart';
import 'package:homework_4/edit_page.dart';
import 'package:path_provider/path_provider.dart';

class ContactPage extends StatefulWidget {
  static String id = "contact_id";
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String find = "";
  Color activeColor = const Color(0xFF000000);
  Color nonactiveColor = const Color(0xFFADADAD);
  ContactManager contactManager = ContactManager();
  List<String> contacts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: TextField(
                decoration: InputDecoration(
                  suffix: IconButton(
                      onPressed: ()async{
                        var person = await contactManager.getContact(find);
                        print(person);
                      },
                      icon: Icon(Icons.search, color: Colors.black,)),
                ),
                onChanged: (value){
                  find = value;
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future: getContact(),
                  builder: (builder, snapshot) {
                    if (snapshot.hasData && contacts != []) {
                      return ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (itemBuilder, index) {
                            return ListTile(
                              tileColor: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),),
                              leading: const Icon(Icons.person, color: Colors.white,),
                              title: Text(contacts[index].replaceAll(",", " "),style: const TextStyle(color: Colors.white),),
                              trailing: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white,),
                                onPressed: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (builder)=>EditPage(contactInfo: contacts[index])));
                                },
                              ),
                            );
                          });
                    }
                    else if(contacts == []) {
                      return Center(child: Text("There is no contact", style: TextStyle(fontFamily: "Dongle", fontSize: 25, color: nonactiveColor),));
                    }else {
                      return Center(child: Text("There is no contact", style: TextStyle(fontFamily: "Dongle", fontSize: 25, color: nonactiveColor),));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
  Future<List?> getContact() async {
    final file = await _localFile;
    if (await file.exists()) {
      try {
        await file
            .openRead()
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .forEach((line) {
          contacts.add(line);
        });
        return contacts;
      } catch (exception) {
        showDialog(
            context: context,
            builder: (builder) => const AlertDialog(
              content: Text("There is no file"),
            ));
      }
    }
    return null;
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
