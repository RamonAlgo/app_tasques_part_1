import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/BarraContacto.dart';
import 'package:flutter_application_1/components/Botton.dart';
import 'package:flutter_application_1/dades/Contactos.dart';
import 'package:hive/hive.dart';

class PaginaInicial extends StatelessWidget {
  Widget altreWidget() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 58, 27, 15),
        title: Text(
          "Agenda",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 172, 134, 122),
      body: Stack(
        children: [
          FutureBuilder(
            future: Hive.openBox<Contacto>('contactos'),
            builder:
                (BuildContext context, AsyncSnapshot<Box<Contacto>> snapshot) {
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
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No hi han contactes guardats'));
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
                print("BotoAf");
              },
            ),
          ),
          Positioned(
            bottom: 60.0,
            right: 20.0,
            child: altreWidget(),
          ),
        ],
      ),
    );
  }
}
