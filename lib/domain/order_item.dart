import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'pizza.dart';

part 'order_item.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class OrderItem {
  @HiveField(0)
  double price;
  @HiveField(1)
  int countItems;
  @HiveField(2)
  Pizza pizza;

  OrderItem(this.price, this.countItems, this.pizza);

  @override
  String toString() {
    return 'OrderItem{price: $price, countItems: $countItems, pizza: $pizza}';
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);




}