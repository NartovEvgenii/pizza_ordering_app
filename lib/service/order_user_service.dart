import '../domain/order_item.dart';
import '../domain/order_user.dart';
import '../domain/pizza.dart';
import '../repository/order_user_repository.dart';

class OrderUserService {
  OrderUserRepository repository = OrderUserRepository();

  Future<OrderUser> getOrderUser() {
    return repository.getOrderUser();
  }

  Future<void> deleteOrderUser() {
    return repository.deleteOrderUser();
  }

  Future<void> addOrderItem(Pizza pizza) async {
    OrderUser orderUser = await repository.getOrderUser();
    if(orderUser.orderItems.where((item) => item.pizza.idPizza == pizza.idPizza).isNotEmpty){
      int index = orderUser.orderItems.indexWhere((item) => item.pizza.idPizza == pizza.idPizza);
      orderUser.orderItems[index] = OrderItem(
                                    orderUser.orderItems[index].price + pizza.price!,
                                    orderUser.orderItems[index].countItems + 1,
                                    pizza);
    } else {
      orderUser.orderItems.add(OrderItem(pizza.price!, 1, pizza));
    }
    orderUser.fullPrice = orderUser.fullPrice + pizza.price!;
    return  repository.saveOrderUser(orderUser);
  }

  Future<void> deleteOrderItem(int idPizza) async {
    OrderUser orderUser = await repository.getOrderUser();
    int removedIndex = orderUser.orderItems.indexWhere((item) => item.pizza.idPizza == idPizza);
    orderUser.fullPrice = orderUser.fullPrice - orderUser.orderItems[removedIndex].price;
    orderUser.orderItems.removeAt(removedIndex);
    return  repository.saveOrderUser(orderUser);
  }

  Future<void> increaseOrderItem(int idPizza) async {
    OrderUser orderUser = await repository.getOrderUser();
    int decreasedIndex = orderUser.orderItems.indexWhere((item) => item.pizza.idPizza == idPizza);
    orderUser.fullPrice = orderUser.fullPrice + orderUser.orderItems[decreasedIndex].pizza.price!;
    orderUser.orderItems[decreasedIndex].countItems++;
    orderUser.orderItems[decreasedIndex].price = orderUser.orderItems[decreasedIndex].price + orderUser.orderItems[decreasedIndex].pizza.price!;
    return repository.saveOrderUser(orderUser);
  }

  Future<void> decreaseOrderItem(int idPizza) async {
    OrderUser orderUser = await repository.getOrderUser();
    int decreasedIndex = orderUser.orderItems.indexWhere((item) => item.pizza.idPizza == idPizza);
    if(orderUser.orderItems[decreasedIndex].countItems > 1){
      orderUser.fullPrice =orderUser.fullPrice - orderUser.orderItems[decreasedIndex].pizza.price!;
      orderUser.orderItems[decreasedIndex].countItems--;
      orderUser.orderItems[decreasedIndex].price =orderUser.orderItems[decreasedIndex].price - orderUser.orderItems[decreasedIndex].pizza.price!;
      return repository.saveOrderUser(orderUser);
    }
  }

}