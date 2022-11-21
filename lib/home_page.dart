import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 150,
                height: 150,
                child: Lottie.asset('source/call.json')),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                ElevatedButton.icon(
                  onPressed: (){},
                  icon: const Icon(Icons.perm_contact_calendar_rounded, color: Colors.white,),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                  label: const Text("Contacts", style: TextStyle(fontFamily: "Dongle", fontSize: 30, color: Colors.white),),
                ),
                ElevatedButton.icon(
                  onPressed: (){},
                  icon: const Icon(Icons.add, color: Colors.white,),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                  label: const Text("Add Contact", style: TextStyle(fontFamily: "Dongle", fontSize: 30, color: Colors.white),),
                ),
              ],),
            ),
          ],
        ),
      ),
    );
  }
}
