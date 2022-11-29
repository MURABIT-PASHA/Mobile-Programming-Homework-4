import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ContactManager {
  Future<List<String>> readContacts() async {
    List<String> contactList = [];
    final file = await _localFile;
    var sinkR = file.openRead();
    if (await file.exists()) {
      try {
        await sinkR
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .forEach((line) {
          contactList.add(line);
        });
        return contactList;
      } catch (e) {
        return contactList;
      }
    } else {
      return contactList;
    }
  }

  Future<bool> removeContact(String number) async {
    bool returnType = false;
    final file = await _localFile;
    var sinkR = file.openRead();
    if (await file.exists()) {
      List<String> contacts = await readContacts();
      int index = 0;
      try {
        await sinkR
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .forEach((line) {

          var contact = line.toString().split(",");
          if (contact[2] == number) {
            contacts.removeAt(index);
            returnType = true;
          }
          index++;
        });
        var sinkW = file.openWrite(mode: FileMode.write);
        sinkW.write("");
        sinkW.close();
        var sinkA = file.openWrite(mode: FileMode.append);
        for(String contact in contacts){
          sinkA.write("$contact\n");
        }
        sinkA.close();
        return returnType;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> findByNumber(String number) async {
    bool returnType = false;
    final file = await _localFile;
    var sinkR = file.openRead();
    if (await file.exists()) {
      try {
        await sinkR
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .forEach((line) {
          var contact = line.toString().split(",");
          if (contact[2] == number) {
            returnType = true;
          }
        });
        return returnType;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }
  Future<bool> findByName(String name) async {
    bool returnType = false;
    final file = await _localFile;
    var sinkR = file.openRead();
    if (await file.exists()) {
      try {
        await sinkR
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .forEach((line) {
          var contact = line.toString().split(",");
          if (contact[0] == name) {
            returnType = true;
          }
        });
        return returnType;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> addContact(String name, String surname, String number) async {
    if (!await findByNumber(number) && !(await readContacts() == [])) {
      final file = await _localFile;
      var sinkW = file.openWrite(mode: FileMode.append);
      sinkW.write("$name,$surname,$number\n");
      sinkW.close();
      return true;
    } else if (!await findByNumber(number) && (await readContacts() == [])){
      final file = await _localFile;
      var sinkW = file.openWrite(mode: FileMode.write);
      sinkW.write("$name,$surname,$number\n");
      sinkW.close();
      return true;
    }else{
      return false;
    }
  }

  Future<bool> editContact(String name, String surname, String number, String oldNumber) async {
    if(await removeContact(oldNumber)){
      if(await addContact(name, surname, number)){
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  Future<String> getContact(name) async {
    String specificLine = "";
    if(await findByName(name)){
      final file = await _localFile;
      var sinkR = file.openRead();
      await sinkR
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .forEach((line) {
        var contact = line.toString().split(",");
        if (contact[0] == name) {
          specificLine = "${contact[0]}${contact[1]}${contact[2]}";
        }
      });
    }
      return specificLine;
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
