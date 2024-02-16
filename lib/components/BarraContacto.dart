import 'package:flutter/material.dart';
import 'package:flutter_application_1/dades/Contactos.dart';
import 'package:flutter_application_1/pagines/ContactoDetalle.dart';

class BarraContacto extends StatelessWidget {
  final Contacto contacto;

  const BarraContacto({Key? key, required this.contacto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.brown,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: Colors.brown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ContactoDetalle(contacto: contacto),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.brown,
                        ),
                        child: Text(
                          "Ver",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          final TextEditingController _controller =
                              TextEditingController(
                            text: contacto.nombre,
                          );
                          final String? newName = await showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Modificar Contacte'),
                              content: TextField(
                                controller: _controller,
                                decoration:
                                    InputDecoration(hintText: 'Nou Nom'),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context)
                                      .pop(_controller.text),
                                  child: Text('Guardar'),
                                ),
                              ],
                            ),
                          );
                          if (newName != null && newName.isNotEmpty) {
                            contacto.nombre = newName;
                            await saveContact(contacto);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.brown,
                        ),
                        child: Text(
                          "Modificar",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          bool confirmDelete = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Eliminar Contacte'),
                                  content: Text(
                                      'Estas segur que vols eliminar el contacte?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text('Eliminar'),
                                    ),
                                  ],
                                ),
                              ) ??
                              false;
                          if (confirmDelete) {
                            await deleteContact(contacto.key);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.brown,
                        ),
                        child: Text(
                          "Eliminar",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(16.0),
            backgroundColor: Colors.brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                contacto.nombre,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
