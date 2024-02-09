import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemTasca extends StatelessWidget {
  final String valorText;
  final VoidCallback seleccionarContacto;

  const ItemTasca({
    Key? key,
    required this.valorText,
    required this.seleccionarContacto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(valorText),
      onTap: seleccionarContacto, 
    );
  }
}