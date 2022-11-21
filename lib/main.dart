import 'package:flutter/material.dart';
import 'package:homework_4/contact_page.dart';
import 'package:homework_4/home_page.dart';
import 'package:homework_4/login_page.dart';
import 'package:homework_4/registration_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id : (context) => const LoginPage(),
        RegistrationPage.id : (context) => const RegistrationPage(),
        ContactPage.id : (context) => const ContactPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
      ),
    );
  }
}
