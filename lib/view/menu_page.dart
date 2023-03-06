import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../domain/Pizza.dart';
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

  final _settingsService = GetIt.I.get<SettingsService>();
  final _pizzaService = GetIt.I.get<PizzaService>();

  @override
  Widget build(BuildContext context) {
    _pizzaService.loadPizzas();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Menu', style: TextStyles.textHeader),
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
                              const EdgeInsets.fromLTRB(15, 15, 15, 5),
                              child: Container(
                                height: 30,
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
                      var pizzas = snapshot.data!;
                      return Container();
                    }
                    return Container();
                  }
                )
          ],
        )
    );
  }
}