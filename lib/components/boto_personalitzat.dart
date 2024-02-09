import 'package:flutter/material.dart';

class BotoPersonalitzat extends StatelessWidget {

  String textBoto;
  Function()? accioBoto;

  BotoPersonalitzat({
    super.key,
    required this.textBoto,
    required this.accioBoto,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: accioBoto,
      color: const Color.fromARGB(255, 85, 85, 85),
      child: Text(textBoto),
    );
  }
}