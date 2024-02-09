import 'package:hive/hive.dart';

class BaseDeDadesAppContactes {

  final _boxContacte = Hive.box("box_Contacte");

  void crearDadesInicials() {
    List llistaContactes = [
      {"nom": "Algo"},
    ];
    _boxContacte.put("contactes", llistaContactes);
  }

  List<Map<String, dynamic>> carregarDades() {
    return _boxContacte.get("contactes", defaultValue: []);
  }

  void afegirContacte(String nom) {
    List<Map<String, dynamic>> contactes = carregarDades();
    contactes.add({"nom": nom});
    _boxContacte.put("contactes", contactes);
  }

  void actualitzarContacte(int index, String nom) {
    List<Map<String, dynamic>> contactes = carregarDades();
    contactes[index] = {"nom": nom};
    _boxContacte.put("contactes", contactes);
  }

  void eliminarContacte(int index) {
    List<Map<String, dynamic>> contactes = carregarDades();
    contactes.removeAt(index);
    _boxContacte.put("contactes", contactes);
  }
}
