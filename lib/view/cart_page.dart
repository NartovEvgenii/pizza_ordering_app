import 'package:flutter/material.dart';

import '../styles/Styles.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Cart', style: TextStyles.textHeader),
          centerTitle: true,
          backgroundColor: Colors.orange[200],
        ),
        body: Text("CartPage")
    );
  }
}