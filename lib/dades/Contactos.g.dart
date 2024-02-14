// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Contactos.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactoAdapter extends TypeAdapter<Contacto> {
  @override
  final int typeId = 0;

  @override
  Contacto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contacto(
      nombre: fields[0] as String,
      numTel: fields[1] as String,
      email: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Contacto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.numTel)
      ..writeByte(2)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
