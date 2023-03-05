import 'package:hive/hive.dart';

import '../domain/settings.dart';

abstract class AbstractSettingsRepository {
  Future<Settings?> getSettings();

  Future<void> saveSettings(Settings settings);

  Future<void> deleteSettings();
}

class SettingsRepository extends AbstractSettingsRepository {
  //todo fix it

  @override
  Future<Settings?> getSettings() async {
    var box = await Hive.openBox<Settings>('settings');
    return box.get('settings');
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    var box = await Hive.openBox<Settings>('settings');
    return box.put('settings', settings);
  }

  @override
  Future<void> deleteSettings() async {
    var box = await Hive.openBox<Settings>('settings');
    return box.delete('settings');
  }
}
