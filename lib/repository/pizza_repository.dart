import 'package:hive/hive.dart';

import '../domain/Pizza.dart';


abstract class AbstractPizzaRepository {
  Future<List<Pizza>?> getPizzas();

  Future<void> addPizza(Pizza pizza);

}

class PizzaRepository extends AbstractPizzaRepository {
  @override
  Future<List<Pizza>> getPizzas() async {
    var box = await Hive.openBox<Pizza>('pizzas');
    return List.of(box.values);
  }

  @override
  Future<void> addPizza(Pizza pizza) async {
    var box = await Hive.openBox<Pizza>('pizzas');
    await  box.add(pizza);
  }

}