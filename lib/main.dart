import 'package:flutter/material.dart';
import 'package:flutter_application_1/dades/Contactos.dart';
import 'package:flutter_application_1/pagines/pagina_inicial.dart';
import 'package:hive_flutter/hive_flutter.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ContactoAdapter());

  await Hive.openBox<Contacto>("box_Contacte");

  runApp(const AppAgenda());
}

class AppAgenda extends StatelessWidget {
  const AppAgenda({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginaInicial(),
    );
  }
}
