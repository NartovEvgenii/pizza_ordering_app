import 'package:pizza_ordering_app/domain/address.dart';

import '../domain/settings.dart';
import '../repository/settings_repository.dart';

class SettingsService {
  SettingsRepository repository = SettingsRepository();

  Future<Settings?> getSettings() {
    return repository.getSettings();
  }

  Future<void> updateGeneralAddress(Address address) async {
    Settings? settings = await repository.getSettings();
    settings?.address = address;
    return repository.saveSettings(settings!);
  }

  Future<void> saveSettings(Settings settings) {
    //post to save user and get Token
    return repository.saveSettings(settings);
  }

  Future<void> deleteSettings() {
    return repository.deleteSettings();
  }

  Future<bool> isLoggedIn() async {
    return await getSettings() != null;
  }
}
