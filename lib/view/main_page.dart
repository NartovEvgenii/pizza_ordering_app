import 'package:flutter/material.dart';
import 'package:pizza_ordering_app/view/cart_page.dart';
import 'package:pizza_ordering_app/view/menu_page.dart';
import 'package:pizza_ordering_app/view/user_page.dart';


class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}


class _MainPageState extends State<MainPage> {
  int index = 0;

  final screens  = const [
    MenuPage(),
    UserPage(),
    CartPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
            backgroundColor: Colors.orange,
            selectedIndex: index,
            onDestinationSelected: (value) => setState(() => {index = value}),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.account_circle),
                  selectedIcon: Icon(Icons.account_circle),
                  label: 'Account'),
              NavigationDestination(
                  icon: Icon(Icons.add_shopping_cart),
                  selectedIcon: Icon(Icons.add_shopping_cart),
                  label: 'Cart'),
            ]
        ),
        body: screens[index]
    );

  }
}
