import 'package:hive/hive.dart';

import 'address.dart';

part 'settings.g.dart';

@HiveType(typeId: 0)
class Settings extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String surname;
  @HiveField(2)
  String email;
  @HiveField(3)
  String token;
  @HiveField(4)
  Address address;

  Settings(this.name, this.surname, this.email, this.token, this.address);

  @override
  String toString() {
    return 'Settings{name: $name, surname: $surname, email: $email, token: $token, address: $address}';
  }
}