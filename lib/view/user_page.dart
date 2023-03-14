import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza_ordering_app/domain/address.dart';
import 'package:pizza_ordering_app/service/address_service.dart';

import '../domain/settings.dart';
import '../service/order_user_service.dart';
import '../service/settings_service.dart';
import '../styles/Styles.dart';
import 'intro_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> {

  final _orderUserService = GetIt.I.get<OrderUserService>();
  final _settingsService = GetIt.I.get<SettingsService>();
  final _addressService = GetIt.I.get<AddressService>();
  List<Address> _userAddresses = [];
  Address? _generalAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
          title: const Text('Profile', style: TextStyles.textHeader),
          centerTitle: true,
          backgroundColor: Colors.orange[200],
        ),
        body: FutureBuilder<Settings?>(
            future: _settingsService.getSettings(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var settings = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(15, 15, 15, 5),
                        child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${settings.name} ${settings.surname}",
                                style: TextStyles.textHeader,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(83, 35),
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  )
                                ),
                                onPressed: () => logOutButtonClicked(context),
                                child: const Text('Log out',
                                    style: TextStyles.textButton
                                ),
                              )
                            ],
                        )
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('Addresses',
                          style: TextStyles.textButton,
                        ),
                      ),
                      getUserAddresses(settings.address.idAddress!),
                    ]
                );
              }
              return Container();
            })
    );
  }

  FutureBuilder<List<Address>> getUserAddresses(String idGeneralAddress){
    return FutureBuilder<List<Address>>(
        future: _addressService.getAddresses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _userAddresses = snapshot.data!;
            _generalAddress = _userAddresses.firstWhere((address) => address.idAddress == idGeneralAddress);
            return Flexible(
                child: ListView.builder(
                  itemCount: _userAddresses.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    return RadioListTile<Address>(
                      title: Text(_userAddresses[index].getTitle()),
                      value: _userAddresses[index],
                      groupValue: _generalAddress,
                      onChanged: (Address? value) {
                        setState(() {
                          _generalAddress = value;
                          _settingsService.updateGeneralAddress(value!);
                        });
                      },
                    );
                  },
                )
            );
          }
          return Container();
        }
    );
  }

  Future<dynamic> logOutButtonClicked(BuildContext context) {
    _settingsService.deleteSettings();
    _orderUserService.deleteOrderUser();
    _addressService.deleteAddresses();
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  const IntroPage(),
    ));
  }
}