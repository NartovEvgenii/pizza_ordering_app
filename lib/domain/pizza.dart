import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pizza.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Pizza {
  @HiveField(0)
  int? idPizza;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? imagePath;
  @HiveField(3)
  String? description;
  @HiveField(4)
  double? price;


  Pizza(this.idPizza, this.title, this.imagePath, this.description, this.price);

  factory Pizza.fromJson(Map<String, dynamic> json) => _$PizzaFromJson(json);

  Map<String, dynamic> toJson() => _$PizzaToJson(this);


  @override
  String toString() {
    return 'Pizza{idPizza: $idPizza, title: $title, imagePath: $imagePath, description: $description, price: $price}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pizza &&
          runtimeType == other.runtimeType &&
          idPizza == other.idPizza &&
          title == other.title &&
          imagePath == other.imagePath &&
          description == other.description &&
          price == other.price;

  @override
  int get hashCode =>
      idPizza.hashCode ^
      title.hashCode ^
      imagePath.hashCode ^
      description.hashCode ^
      price.hashCode;
}

