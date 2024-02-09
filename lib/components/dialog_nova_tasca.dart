import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/boto_personalitzat.dart';

class DialogNovaTasca extends StatefulWidget {
  final Function(String nombre, String numero, String email)? accioGuardar;
  final Function()? accioTancar;

  DialogNovaTasca({
    super.key,
    this.accioGuardar,
    this.accioTancar,
  });

  @override
  State<DialogNovaTasca> createState() => _DialogNovaTascaState();
}

class _DialogNovaTascaState extends State<DialogNovaTasca> {
   TextEditingController nombreController = TextEditingController();
   TextEditingController numeroController = TextEditingController();
   TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 233, 233, 233),
      content: Container(
        height: 500,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                hintText: "Nom del contacte",
              ),
            ),
            TextField(
              controller: numeroController,
              decoration: InputDecoration(
                hintText: "Numero",
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Correu electrónic",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (widget.accioGuardar != null) {
                      widget.accioGuardar!(
                        nombreController.text,
                        numeroController.text,
                        emailController.text,
                      );
                    }
                  },
                  child: Text("Guardar Contacte"),
                ),
                ElevatedButton(
                  onPressed: widget.accioTancar,
                  child: Text("Tancar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
