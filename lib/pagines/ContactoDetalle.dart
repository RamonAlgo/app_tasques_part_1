import 'package:flutter/material.dart';
import 'package:flutter_application_1/dades/Contactos.dart';

class ContactoDetalle extends StatelessWidget {
  final Contacto contacto;

  const ContactoDetalle({Key? key, required this.contacto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contacto.nombre, selectionColor: Color.fromARGB(255, 196, 196, 196),),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nombre: ${contacto.nombre}",
              style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 0, 0, 0) ),
            ),
            SizedBox(height: 8),
            Text(
              "Número de Teléfono: ${contacto.numTel}",
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: 8),
            Text(
              "Correo Electrónico: ${contacto.email}",
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
      ),
    );
  }
}
