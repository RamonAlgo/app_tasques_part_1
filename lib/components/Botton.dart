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

  BotonAgregar({
    Key? key,
    required this.onPressed,
    this.bottom = 20.0,
    this.right = 20.0,
  }) : super(key: key);

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
              return Theme(
                data: Theme.of(context).copyWith(
                    dialogBackgroundColor: Color.fromARGB(255, 172, 134, 122)),
                child: AlertDialog(
                  title: Text("Afegir nou contacte"),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: nombreController,
                          decoration: const InputDecoration(
                              labelText: 'Nom',
                              border: OutlineInputBorder(
                                  )),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: numTelController,
                          decoration: const InputDecoration(
                              labelText: 'Numero de telèfon',
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              labelText: 'Correu',
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown),
                      child: const Text("Guardar",
                          style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown),
                      child: const Text("Cancelar",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 58, 27, 15),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 241, 241, 241)),
      ),
    );
  }
}
