import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorageService {
  Future<dynamic> getValue<T>(String key);
  Future<SharedPreferences> setInstance();
  Future<bool> setValue<T>(String key, dynamic value);
}
