import '../domain/settings.dart';
import '../repository/settings_repository.dart';

class SettingsService {
  SettingsRepository repository = SettingsRepository();

  Future<Settings?> getSettings() {
    return repository.getSettings();
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
