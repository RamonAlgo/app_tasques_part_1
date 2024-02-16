import 'package:flutter/material.dart';
import 'package:flutter_application_1/dades/Contactos.dart';

class ContactoDetalle extends StatelessWidget {
  final Contacto contacto;

  const ContactoDetalle({Key? key, required this.contacto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 172, 134, 122),
      appBar: AppBar(
        title: Text(
          contacto.nombre,
          style: TextStyle(color: Colors.white), 
        ),
        centerTitle: true, 
        backgroundColor: const Color.fromARGB(255, 58, 27, 15),
        iconTheme: IconThemeData(
          color: Colors.white, 
        ),
      ),
      body: Center( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, 
            children: [
              Card( color: Colors.brown,
                child: ListTile(
                  title: Text(
                    "Nom: ${contacto.nombre}",
                    style: TextStyle(fontSize: 24,color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Card( color: Colors.brown,
                child: ListTile(
                  title: Text(
                    "Numero de telèfon: ${contacto.numTel}",
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Card( color: Colors.brown,
                child: ListTile(
                  title: Text(
                    "Correu electrónic: ${contacto.email}",
                    style: TextStyle(fontSize: 20,color: Colors.white),
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
