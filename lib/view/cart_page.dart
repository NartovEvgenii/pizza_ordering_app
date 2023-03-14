import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza_ordering_app/domain/order_user.dart';
import 'package:pizza_ordering_app/domain/settings.dart';

import '../service/order_user_service.dart';
import '../service/settings_service.dart';
import '../styles/Styles.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  final _orderUserService = GetIt.I.get<OrderUserService>();
  final _settingsService = GetIt.I.get<SettingsService>();
  String imgUrl = 'http://10.0.2.2:8080/pizza/img/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Cart', style: TextStyles.textHeader),
          centerTitle: true,
          backgroundColor: Colors.orange[200],
        ),
        body: FutureBuilder<OrderUser>(
              future: _orderUserService.getOrderUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.orderItems.isNotEmpty) {
                  var orderuser = snapshot.data!;
                  var orderItems = orderuser.orderItems;
                  return  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: ListView.builder(
                              itemCount: orderItems.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              itemBuilder: (context, index) {
                                return Container(
                                    margin:  EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(Radius.circular(13.0))
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.network(imgUrl + orderItems[index].pizza.imagePath!,
                                                  height: 125,
                                                  fit: BoxFit.fitWidth
                                              ),
                                              Padding(padding: const EdgeInsets.only(left: 3),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(
                                                            width: 210,
                                                            child: Text(orderItems[index].pizza.title!,
                                                              style: TextStyles.textHeader,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(Icons.cancel_outlined),
                                                            alignment: Alignment.topRight,
                                                            color: Colors.red,
                                                            iconSize: 40,
                                                            onPressed: () => _onDeleteOrderItemClicked(orderItems[index].pizza.idPizza!),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 230,
                                                        height: 60,
                                                        child: Text(
                                                          orderItems[index].pizza.description!,
                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,
                                                          softWrap: false,
                                                          style: const TextStyle(color: Colors.black87,
                                                              fontSize: 16.0),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove_circle_outline),
                                                alignment: Alignment.topLeft,
                                                iconSize: 35,
                                                onPressed: () => _onDecreaseOrderItemClicked(orderItems[index].pizza.idPizza!),
                                              ),
                                              Text(' ${orderItems[index].countItems} ',
                                                style: TextStyles.textButton,
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.add_circle_outline),
                                                iconSize: 35,
                                                onPressed: () => _onIncreaseOrderItemClicked(orderItems[index].pizza.idPizza!),
                                              ),
                                              Text('  \$ ${orderItems[index].price}',
                                                style: TextStyles.textButton,
                                              )
                                            ],
                                          )
                                        ]
                                    )
                                );
                              }
                          )
                      ),
                      Column(
                        children: [
                          getAddress(),
                          Row(
                            children: [
                            Container(
                              width: 260,
                              margin: EdgeInsets.fromLTRB(30, 0, 15, 5),
                              child: ElevatedButton(
                                style: ButtonStyles.buttonStyle,
                                onPressed: () => _onPayClicked(context),
                                child: const Text('Pay',
                                    style: TextStyles.textButton
                                ),
                              ),
                            ),
                              Text('Total \n \$ ${orderuser.fullPrice}',
                                style: TextStyles.textButton,
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  );
                }
                return Container();
              }
          )
    );
  }

  FutureBuilder<Settings?> getAddress(){
    return FutureBuilder<Settings?>(
        future: _settingsService.getSettings(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var settings = snapshot.data!;
            return Column(
                children: [
                  Padding(
                      padding:
                      const EdgeInsets.fromLTRB(10, 15, 15, 8),
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
        });
  }


  Future<void> _onDeleteOrderItemClicked(int idPizza) async {
    await _orderUserService.deleteOrderItem(idPizza);
    setState(() {
    });
  }

  Future<void> _onIncreaseOrderItemClicked(int idPizza) async {
    await _orderUserService.increaseOrderItem(idPizza);
    setState(() {
    });
  }

  Future<void> _onDecreaseOrderItemClicked(int idPizza) async {
    await _orderUserService.decreaseOrderItem(idPizza);
    setState(() {
    });
  }

  Future<void> _onPayClicked(BuildContext context) async {
    await _orderUserService.deleteOrderUser();
    setState(() {
    });
  }
}