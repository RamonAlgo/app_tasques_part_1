import 'package:hive/hive.dart';

class BaseDeDadesAppContactes {
  late Box _boxDeContactes;

  BaseDeDadesAppContactes() {
    _abrirBox();
  }

  Future<void> _abrirBox() async {
    _boxDeContactes = await Hive.openBox("box_Contactes");
  }

  Future<void> agregarContacto(String nom, String numTel, String email) async {
    final contacto = {
      "nom": nom,
      "numTel": numTel,
      "email": email,
    };
    await _boxDeContactes.put(numTel, contacto);
  }

  Future<void> eliminarContacto(String numTel) async {
    await _boxDeContactes.delete(numTel);
  }

  Future<void> modificarContacto(String numTel, String nuevoNom, String nuevoNumTel, String nuevoEmail) async {
    final contacto = {
      "nom": nuevoNom,
      "numTel": nuevoNumTel,
      "email": nuevoEmail,
    };
    await _boxDeContactes.put(numTel, contacto);
  }

  List<Map<String, dynamic>> mostrarContactos() {
    final List<Map<String, dynamic>> contactos = [];
    for (var i = 0; i < _boxDeContactes.length; i++) {
      final key = _boxDeContactes.keyAt(i);
      final contacto = _boxDeContactes.get(key) as Map<String, dynamic>;
      contactos.add(contacto);
    }
    return contactos;
  }
}
