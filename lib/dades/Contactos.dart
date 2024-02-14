import 'package:hive/hive.dart';

part 'Contactos.g.dart';

@HiveType(typeId: 0)
class Contacto extends HiveObject { 
  @HiveField(0)
  String nombre;

  @HiveField(1)
  String numTel;

  @HiveField(2)
  String email;

  Contacto({required this.nombre, required this.numTel, required this.email});
}


void guardarContacto(Contacto contacto) async {
  var box = await Hive.openBox<Contacto>('contactos');
  await box.add(contacto);
}
Future<void> saveContact(Contacto contacto) async {
  var box = await Hive.openBox<Contacto>('contactos');
  
 
  if (contacto.key != null) {
    await box.put(contacto.key, contacto); 
  } else {
    await box.add(contacto);
  }
}

Future<void> deleteContact(dynamic contactoKey) async {
  var box = await Hive.openBox<Contacto>('contactos');
  await box.delete(contactoKey);
}



