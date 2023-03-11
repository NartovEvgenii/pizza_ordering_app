import 'package:hive/hive.dart';
import 'package:pizza_ordering_app/domain/order_user.dart';

abstract class AbstractOrderUserRepository {
  Future<OrderUser> getOrderUser();

  Future<void> deleteOrderUser();

}

class OrderUserRepository extends AbstractOrderUserRepository {
  @override
  Future<void> deleteOrderUser() async {
    var box = await Hive.openBox<OrderUser>('order_user');
    return box.delete('order_user');
  }

  @override
  Future<void> saveOrderUser(OrderUser orderUser) async {
    var box = await Hive.openBox<OrderUser>('order_user');
    return box.put('order_user', orderUser);
  }

  @override
  Future<OrderUser> getOrderUser() async {
    var box = await Hive.openBox<OrderUser>('order_user');
    if (box.isEmpty){
      box.put('order_user', OrderUser(0));
      return box.get('order_user')!;
    }else{
      return box.get('order_user')!;
    }
  }


}