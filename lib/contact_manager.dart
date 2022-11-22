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
    var sinkA = file.openWrite(mode: FileMode.append);
    var sinkW = file.openWrite(mode: FileMode.writeOnly);
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
          if (contact[3] == number) {
            contacts.removeAt(index);
            returnType = true;
          }
          index++;
        });
        sinkW.write("");
        sinkW.close();
        for(String contact in contacts){
          sinkA.write(contact);
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

  Future<bool> findContact(String number) async {
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

  Future<bool> addContact(String name, String surname, String number) async {
    if (!await findContact(number) && !(await readContacts() == [])) {
      final file = await _localFile;
      var sinkW = file.openWrite(mode: FileMode.append);
      sinkW.write("$name,$surname,$number\n");
      sinkW.close();
      return true;
    } else if (!await findContact(number) && (await readContacts() == [])){
      final file = await _localFile;
      var sinkW = file.openWrite(mode: FileMode.write);
      sinkW.write("$name,$surname,$number\n");
      sinkW.close();
      return true;
    }else{
      return false;
    }
  }

  Future<bool> editContact(String name, String surname, String newNumber, String oldNumber) async {
    if(await removeContact(oldNumber)){
      if(await addContact(name, surname, newNumber)){
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

  Future<String> getContact(String name, String surname, String number) async {
    String specificLine = "";
    final file = await _localFile;
    var sinkR = file.openRead();
      try {
        await sinkR
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .forEach((line) {
          var person = line.toString().split(",");
          if (person[2] == number) {
            specificLine = person.toString();
          }
        });
        print(specificLine);
        return specificLine;
    }
    catch(e){
        return "$name,$surname,$number";
    }
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
