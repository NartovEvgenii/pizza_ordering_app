import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Address {
  @HiveField(0)
  final String? idAddress;
  @HiveField(1)
  final String? title;

  Address({this.idAddress, this.title});

  String getTitle() {
      return title!;
  }

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          idAddress == other.idAddress &&
          title == other.title;

  @override
  int get hashCode => idAddress.hashCode ^ title.hashCode;

  @override
  String toString() {
    return 'Address{idAddress: $idAddress, title: $title}';
  }

}