// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pizza.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PizzaAdapter extends TypeAdapter<Pizza> {
  @override
  final int typeId = 2;

  @override
  Pizza read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pizza(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Pizza obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.idPizza)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PizzaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pizza _$PizzaFromJson(Map<String, dynamic> json) => Pizza(
      json['idPizza'] as int?,
      json['title'] as String?,
      json['imagePath'] as String?,
      json['description'] as String?,
      (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PizzaToJson(Pizza instance) => <String, dynamic>{
      'idPizza': instance.idPizza,
      'title': instance.title,
      'imagePath': instance.imagePath,
      'description': instance.description,
      'price': instance.price,
    };
