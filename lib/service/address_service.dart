import 'dart:convert';

import '../domain/address.dart';
import 'package:http/http.dart' as http;

class AddressService {


  Future<List<Address>> getAddresses() async {
    var urlAddresses = Uri.http('10.0.2.2:8080', 'address');

    var response = await http.get(urlAddresses);
    var parsedJsonArray = const JsonDecoder().convert(response.body);

    List<Address> addresses = [];

    for (int i = 0; i < parsedJsonArray.length; i++) {
      var parsedJsonObj = parsedJsonArray[i];
      String id = parsedJsonObj['idAddress'].toString();
      String title = parsedJsonObj['title'];
      addresses.add(Address(idAddress: id, title: title));
    }

    return addresses;
  }


}