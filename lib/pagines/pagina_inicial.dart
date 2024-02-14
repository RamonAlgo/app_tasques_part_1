import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/BarraContacto.dart';
import 'package:flutter_application_1/components/Botton.dart';
import 'package:flutter_application_1/dades/Contactos.dart'; 
import 'package:hive/hive.dart';

class PaginaInicial extends StatelessWidget {
  Widget otroWidget() {
    return Container(
    
    );
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
      body: Stack(
        children: [
          FutureBuilder(
            future: Hive.openBox<Contacto>('contactos'),
            builder: (BuildContext context, AsyncSnapshot<Box<Contacto>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Box<Contacto> box = snapshot.data!;
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      Contacto contacto = box.getAt(index)!;
                      return Column(
                        children: [
                          BarraContacto(contacto: contacto), 
                          Divider(),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No hay contactos guardados'));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: BotonAgregar(
              onPressed: () {
                print("Botón de agregar presionado");
              },
            ),
          ),
          Positioned(
            bottom: 60.0, 
            right: 20.0, 
            child: otroWidget(), 
          ),
        ],
      ),
    );
  }
}
