// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderUserAdapter extends TypeAdapter<OrderUser> {
  @override
  final int typeId = 4;

  @override
  OrderUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderUser(
      fields[0] as double,
    )..orderItems = (fields[1] as List).cast<OrderItem>();
  }

  @override
  void write(BinaryWriter writer, OrderUser obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.fullPrice)
      ..writeByte(1)
      ..write(obj.orderItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderUser _$OrderUserFromJson(Map<String, dynamic> json) => OrderUser(
      (json['fullPrice'] as num).toDouble(),
    )..orderItems = (json['orderItems'] as List<dynamic>)
        .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$OrderUserToJson(OrderUser instance) => <String, dynamic>{
      'fullPrice': instance.fullPrice,
      'orderItems': instance.orderItems,
    };
