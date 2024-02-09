import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/BarraContacto.dart';
import 'package:flutter_application_1/components/Botton.dart';
import 'package:flutter_application_1/dades/database.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  late BaseDeDadesAppContactes baseDeDatos;

  @override
  void initState() {
    super.initState();
    inicializarBaseDeDatos();
  }

  Future<void> inicializarBaseDeDatos() async {
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    baseDeDatos = BaseDeDadesAppContactes();
    await baseDeDatos.abrirBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Agenda",
          style: TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: baseDeDatos.mostrarContactos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final contacto = snapshot.data![index];
                  return BarraContacto(
                    nombreContacto: contacto['nombre'] ?? '',
                  );
                },
              );
            } else {
              return Center(child: Text("No hay contactos"));
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implementar acción de agregar contacto
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}
