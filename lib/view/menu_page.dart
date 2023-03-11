import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza_ordering_app/service/order_user_service.dart';

import '../domain/pizza.dart';
import '../domain/settings.dart';
import '../service/pizza_service.dart';
import '../service/settings_service.dart';
import '../styles/Styles.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenuPageState();
  }
}

class _MenuPageState extends State<MenuPage> {

  TextEditingController editingController = TextEditingController();
  final _settingsService = GetIt.I.get<SettingsService>();
  final _pizzaService = GetIt.I.get<PizzaService>();
  final _orderUserService = GetIt.I.get<OrderUserService>();
  String imgUrl = 'http://10.0.2.2:8080/pizza/img/';
  List<Pizza> _allPizzas = [];
  List<Pizza> _foundedPizzas = [];


  @override
  Widget build(BuildContext context) {
    _pizzaService.loadPizzas();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
            title: SizedBox(
              height: 45,
              child:TextField(
                onChanged: (value) => _filterSearchResults(value),
                controller: editingController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)))),
              ),
          ),
          centerTitle: true,
          backgroundColor: Colors.orange[200],
        ),
        body: Column(
          children: [
            FutureBuilder<Settings?>(
              future: _settingsService.getSettings(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var settings = snapshot.data!;

                  return Column(
                      children: [
                        Padding(
                            padding:
                            const EdgeInsets.fromLTRB(15, 15, 15, 8),
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.all(Radius.circular(4.0))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("   ${settings.address.getTitle()}",
                                    style: TextStyles.textAddress
                                  ),
                                  const Icon(Icons.location_on,
                                    color: Colors.orange,
                                  )
                                ],
                              )
                            )
                        ),
                      ]
                  );
                }
                return Container();
              }),
              FutureBuilder<List<Pizza>>(
                future: _pizzaService.getPizzas(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if(_allPizzas.isEmpty){
                      _allPizzas = snapshot.data!;
                      _foundedPizzas = [..._allPizzas];
                    }
                    return Flexible(
                      child: ListView.builder(
                        itemCount: _foundedPizzas.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemBuilder: (context, index) {
                          return Container(
                              height: 150,
                              width: 230,
                              margin:  EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(13.0))
                              ),
                              child: Row(
                                children: [
                                  Image.network(imgUrl + _foundedPizzas[index].imagePath!,
                                      height: 150,
                                      fit: BoxFit.fitWidth
                                  ),
                                  Padding(padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 1),
                                        child:Text(_foundedPizzas[index].title!,
                                            style: TextStyles.textHeader
                                          ),
                                      ),
                                      SizedBox(
                                        width: 230,
                                        height: 70,
                                        child: Text(
                                          _foundedPizzas[index].description!,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: const TextStyle(color: Colors.black87,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 232,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('\$ ${_foundedPizzas[index].price!}',
                                                textAlign: TextAlign.start,
                                                style: TextStyles.textButton,
                                              ),
                                              ElevatedButton(
                                                  style: ButtonStyles.buttonADDStyle,
                                                  onPressed: () => _onAddPizzaButtonClicked(_foundedPizzas[index]),
                                                  child: const Text('+ ADD',
                                                      style: TextStyles.textButton
                                                  )
                                              )
                                            ],
                                          )
                                      )
                                      ]
                                    )
                                  )
                                ],
                              )
                          );
                        },
                      )
                    );
                  }
                  return Container();
                }
              )
          ],
        )
    );
  }

  void _filterSearchResults(String query) {
    List<Pizza> results = [];
    _foundedPizzas.clear();
    if (query.isEmpty) {
      results = _allPizzas;
    } else {
      print(query);
      print(_allPizzas);
      results = _allPizzas
          .where((pizza) =>
          pizza.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundedPizzas = results;
    });
    }

  Future<void> _onAddPizzaButtonClicked(Pizza pizza) async {
    print(pizza);
    _orderUserService.addOrderItem(pizza);
  }
}