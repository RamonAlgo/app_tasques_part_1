import 'package:flutter/material.dart';
import 'package:flutter_application_1/pagines/pagina_inicial.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  var _boxContacte = await Hive.openBox("box_Contacte");
  runApp(const AppAgenda());
}

class AppAgenda extends StatelessWidget {
  const AppAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginaInicial(),
    );
  }
}