import 'package:hive/hive.dart';

import '../domain/address.dart';

abstract class AbstractAddressRepository {
  Future<List<Address>> getAddresses();

  Future<void> deleteAddresses();

  Future<void> addAddress(Address address);

}

class AddressRepository extends AbstractAddressRepository {
  @override
  Future<List<Address>> getAddresses() async {
    var box = await Hive.openBox<Address>('addresses');
    return List.of(box.values);
  }

  @override
  Future<void> addAddress(Address address) async {
    var box = await Hive.openBox<Address>('addresses');
    await  box.add(address);
  }

  @override
  Future<void> deleteAddresses() async {
    var box = await Hive.openBox<Address>('addresses');
    await box.clear();
  }

}