import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_item.dart';

part 'order_user.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class OrderUser {

  @HiveField(0)
  double fullPrice = 0;

  @HiveField(1)
  List<OrderItem> orderItems = [];

  OrderUser(this.fullPrice);

  factory OrderUser.fromJson(Map<String, dynamic> json) => _$OrderUserFromJson(json);

  Map<String, dynamic> toJson() => _$OrderUserToJson(this);

  @override
  String toString() {
    return 'OrderUser{fullPrice: $fullPrice, orderItems: $orderItems}';
  }
}