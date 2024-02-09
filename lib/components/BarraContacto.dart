import 'package:flutter/material.dart';

class BotonAgregar extends StatelessWidget {
  final VoidCallback onPressed;
  final double bottom;
  final double right;

  const BotonAgregar({Key? key, required this.onPressed, this.bottom = 20.0, this.right = 20.0}) : super(key: key);

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
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Número de teléfono',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
