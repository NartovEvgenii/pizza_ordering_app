import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pizza_ordering_app/domain/address.dart';
import '../domain/settings.dart';
import '../domain/user.dart';
import '../repository/settings_repository.dart';

class UserService {
  SettingsRepository settingsRepository = SettingsRepository();


  Future<void> login(String email, String password) async {
    var urlLogin = Uri.http('10.0.2.2:8080', 'user/login');

    var response = await http.post(urlLogin,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(User(email, null, null, password, null)));
    var parsedUserJson = const JsonDecoder().convert(response.body);
    settingsRepository.deleteSettings();
    String emailUser = parsedUserJson['email'];
    String name = parsedUserJson['name'];
    String surname = parsedUserJson['surname'];
    String token = parsedUserJson['token'];
    Address address = Address.fromJson(parsedUserJson['address']);
    var settings = Settings(name, surname, emailUser, token, address);
    return settingsRepository.saveSettings(settings);
  }

  Future<void> register(User user) async {
    var urlRegister = Uri.http('10.0.2.2:8080', 'user/register');
    var userResponse = await http.post(urlRegister,
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(user.toJson()));
    var parsedUserJson = const JsonDecoder().convert(userResponse.body);
    settingsRepository.deleteSettings();
    String email = parsedUserJson['email'];
    String name = parsedUserJson['name'];
    String surname = parsedUserJson['surname'];
    String token = parsedUserJson['token'];
    Address address = Address.fromJson(parsedUserJson['address']);
    var settings = Settings(name, surname, email, token, address);
    return settingsRepository.saveSettings(settings);
  }

}