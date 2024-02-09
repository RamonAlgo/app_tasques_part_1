import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/dialog_nova_tasca.dart';
import 'package:flutter_application_1/components/item_tasca.dart';
import 'package:flutter_application_1/dades/database.dart';
import 'package:hive/hive.dart';

class PaginaInicial extends StatefulWidget {
  PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final _boxAppTasques = Hive.box("box_Contacte");
  BaseDeDadesAppContactes bd = BaseDeDadesAppContactes();

  TextEditingController controladorTextFieldDialog = TextEditingController();
  TextEditingController controladorBuscador = TextEditingController();

  List<dynamic> llistaFiltrada = [];

@override
  void initState() {
    super.initState();
    if (_boxAppTasques.get("box_Contacte") == null) {
      bd.crearDadesInicials();
    } else {
      bd.carregarDades();
    }
    llistaFiltrada = bd.llistaContactes;
  }

void accioGuardarImplementada(String? nombre, String? numero, String? email) {
  // Verifica si alguno de los campos es null o vacío.
  if (nombre == null || nombre.isEmpty || numero == null || numero.isEmpty || email == null || email.isEmpty) {
    // Puedes mostrar un mensaje de error o asignar valores predeterminados.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Por favor, rellena todos los campos.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return; // Sale de la función si algún campo es null o vacío.
  }

  final int nuevoId = DateTime.now().millisecondsSinceEpoch; // Genera un ID único.
  setState(() {
    bd.llistaContactes.add({
      'id': nuevoId,
      'nombre': nombre,
      'numero': numero,
      'email': email,
    });
  });
  bd.actualitzarDades();
  Navigator.of(context).pop();
}


 void crearNovaTasca() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogNovaTasca(
          accioGuardar: (nombre, numero, email) => accioGuardarImplementada(nombre, numero, email),
          accioTancar: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void esborrarItem(int index) {
    setState(() {
      bd.llistaContactes.removeAt(index);
    });
    bd.actualitzarDades();
  }
  
  void filtrarContactos(String query) {
    final llistaTemporal = bd.llistaContactes.where((tasca) {
      final titolTasca = tasca[0].toLowerCase();
      final busca = query.toLowerCase();
      return titolTasca.contains(busca);
    }).toList();
    setState(() {
      llistaFiltrada = llistaTemporal;
    });
  }
  
  void verDetalleContacto(BuildContext context, dynamic contacto) {
  int idContacto = contacto['id'] is String ? int.parse(contacto['id']) : contacto['id'];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(contacto['nombre']),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('ID: $idContacto'), 
              Text('Teléfono: ${contacto['telefono']}'),
              Text('Email: ${contacto['email']}'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cerrar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}

  void modificarContacto(BuildContext context, dynamic contacto) {
    TextEditingController nombreController = TextEditingController(text: contacto['nombre']);
    TextEditingController telefonoController = TextEditingController(text: contacto['telefono']);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modificar Contacto'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: nombreController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: telefonoController,
                  decoration: InputDecoration(labelText: 'Teléfono'),
                ),
                // Agrega campos según necesites
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void eliminarContacto(BuildContext context, dynamic contacto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar Contacto'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Estás seguro de que deseas eliminar a ${contacto['nombre']}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void mostrarOpcionesContacto(BuildContext context, dynamic contacto) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.visibility),
                  title: Text('Ver'),
                  onTap: () {
                    Navigator.pop(context);
                    verDetalleContacto(context, contacto);
                  }),
              ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Modificar'),
                  onTap: () {
                    Navigator.pop(context);
                    modificarContacto(context, contacto);
                  }),
              ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Eliminar'),
                  onTap: () {
                    Navigator.pop(context);
                    eliminarContacto(context, contacto);
                  }),
            ],
          ),
        );
      },
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "App Contactos",
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: crearNovaTasca,
        backgroundColor: Color.fromARGB(255, 194, 194, 194),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: controladorBuscador,
              decoration: InputDecoration(
                labelText: 'Buscar contacto',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: filtrarContactos,
            ),
          ),
         Expanded(
          child: ListView.builder(
            itemCount: llistaFiltrada.length,
            itemBuilder: (context, index) {
              return ItemTasca(
                valorText: llistaFiltrada[index][0], 
                seleccionarContacto: () => mostrarOpcionesContacto(context, llistaFiltrada[index]),
              );
              },
            ),
          ),
        ],
      ),
    );
  }
}