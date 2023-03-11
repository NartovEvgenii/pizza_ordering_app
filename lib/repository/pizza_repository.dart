import 'package:hive/hive.dart';

import '../domain/pizza.dart';

abstract class AbstractPizzaRepository {
  Future<List<Pizza>> getPizzas();

  Future<void> deletePizzas();

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

  @override
  Future<void> deletePizzas() async {
    var box = await Hive.openBox<Pizza>('pizzas');
    await box.clear();
  }

}