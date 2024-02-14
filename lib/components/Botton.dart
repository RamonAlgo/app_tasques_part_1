import 'package:flutter/material.dart';
import 'package:flutter_application_1/dades/Contactos.dart';
import 'package:flutter_application_1/pagines/pagina_inicial.dart';
import 'package:hive/hive.dart';

class BotonAgregar extends StatelessWidget {
  final VoidCallback onPressed;
  final double bottom;
  final double right;
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController numTelController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  BotonAgregar(
      {Key? key,
      required this.onPressed,
      this.bottom = 20.0,
      this.right = 20.0})
      : super(key: key);

  void guardarContacto(Contacto nuevoContacto) async {
    final box = await Hive.openBox<Contacto>('contactos');
    await box.add(nuevoContacto);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      right: right,
      child: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nombreController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: numTelController,
                      decoration: InputDecoration(
                        labelText: 'Número de teléfono',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      String nombre = nombreController.text;
                      String numTel = numTelController.text;
                      String email = emailController.text;

                      Contacto nuevoContacto = Contacto(
                          nombre: nombre, numTel: numTel, email: email);

                      guardarContacto(nuevoContacto);

                      Navigator.of(context).pop(); 
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => PaginaInicial()));
                    },
                    child: Text("Guardar"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancelar"),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 126, 126, 126),
        child: Icon(Icons.add, color: const Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }
}
