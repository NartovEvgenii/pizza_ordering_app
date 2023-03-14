import 'dart:convert';

import '../domain/address.dart';
import 'package:http/http.dart' as http;

import '../repository/address_repository.dart';

class AddressService {
  AddressRepository _addressRepository = AddressRepository();


  Future<List<Address>> getFullAddresses() async {
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

  Future<List<Address>> getAddresses() {
    return _addressRepository.getAddresses();
  }

  Future<void> addAddress(Address address) {
    return _addressRepository.addAddress(address);
  }

  Future<void> deleteAddresses() {
    return _addressRepository.deleteAddresses();
  }

}