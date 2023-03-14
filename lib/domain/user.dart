import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String? email;
  final String? name;
  final String? surname;
  final String? password;
  final Address? address;
  List<Address> addresses = [];

  User(this.email, this.name, this.surname, this.password, this.address);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{email: $email, name: $name, surname: $surname, password: $password, address: $address}';
  }


}