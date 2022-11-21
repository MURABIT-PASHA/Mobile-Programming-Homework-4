import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework_4/edit_page.dart';
import 'package:path_provider/path_provider.dart';

class ContactPage extends StatefulWidget {
  static String id = "contact_id";
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    Color activeColor = const Color(0xFF000000);
    Color nonactiveColor = const Color(0xFFADADAD);
    List<String> contacts = [];
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

    return Scaffold(
      body: FutureBuilder(
          future: getContact(),
          builder: (builder, snapshot) {
            if (snapshot.hasData) {
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
            } else {
              return Center(child: Text("There is no contact", style: TextStyle(fontFamily: "Dongle", fontSize: 25, color: nonactiveColor),));
            }
          }),
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
