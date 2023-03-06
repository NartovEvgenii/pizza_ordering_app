import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pizza_ordering_app/domain/address.dart';
import 'package:pizza_ordering_app/service/address_service.dart';
import 'package:pizza_ordering_app/service/pizza_service.dart';
import 'package:pizza_ordering_app/service/settings_service.dart';
import 'package:pizza_ordering_app/service/user_servise.dart';
import 'package:pizza_ordering_app/view/intro_page.dart';

import 'domain/pizza.dart';
import 'domain/settings.dart';

Future<void> main() async {
  await init();
  runApp(MyApp());
}

init() async {
  await initDatabase();
  initDependencies();
}

Future<void> initDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(PizzaAdapter());
}

void initDependencies() {
  GetIt.I.registerSingleton<SettingsService>(SettingsService());
  GetIt.I.registerSingleton<AddressService>(AddressService());
  GetIt.I.registerSingleton<UserService>(UserService());
  GetIt.I.registerSingleton<PizzaService>(PizzaService());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: const IntroPage()
    );
  }
}
