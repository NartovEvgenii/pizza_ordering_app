import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/pizza.dart';
import '../repository/pizza_repository.dart';

class PizzaService {

  final PizzaRepository _pizzaRepository = PizzaRepository();

  Future<void> loadPizzas() async {
    _pizzaRepository.deletePizzas();
    var urlPizzas = Uri.http('10.0.2.2:8080', 'pizza');

    var response = await http.get(urlPizzas);
    var parsedPizzaJsonArray = const JsonDecoder().convert(response.body);
    for (int i = 0; i < parsedPizzaJsonArray.length; i++) {
      var parsedJsonPizza = parsedPizzaJsonArray[i];
      int idPizza = parsedJsonPizza["idPizza"];
      String title = parsedJsonPizza["title"];
      String imagePath = parsedJsonPizza["imagePath"];
      String description = parsedJsonPizza["description"];
      double price = parsedJsonPizza["price"];
      _pizzaRepository.addPizza(Pizza(idPizza, title, imagePath, description, price));
    }
  }

  Future<List<Pizza>> getPizzas() {
    return _pizzaRepository.getPizzas();
  }
}