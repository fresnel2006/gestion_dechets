import 'package:flutter/material.dart';
import 'package:hackaton/Pages/Acceuil.dart';
import 'package:hackaton/Pages/Connexion.dart';
import 'package:hackaton/Pages/CreationCompte.dart';

import 'package:hackaton/Pages/Inscription.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AcceuilPage()
      ),
    );
  }
}
