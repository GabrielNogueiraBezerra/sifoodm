import 'package:shared_preferences/shared_preferences.dart';
import '../interfaces/ilocal_storage_service.dart';

class LocalStorageService extends ILocalStorageService {
  @override
  Future<dynamic> getValue<T>(String key) async {
    return await setInstance().then(
      (sharedPreferences) {
        switch (T) {
          case double:
            return sharedPreferences.getDouble(key);
            break;
          case int:
            return sharedPreferences.getInt(key);
            break;
          case List:
            return sharedPreferences.getStringList(key);
            break;
          case bool:
            return sharedPreferences.getBool(key);
            break;
          default:
            return sharedPreferences.getString(key);
            break;
        }
      },
    );
  }

  @override
  Future<SharedPreferences> setInstance() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<bool> setValue<T>(String key, dynamic value) async {
    return await setInstance().then(
      (sharedPreferences) {
        switch (T) {
          case double:
            return sharedPreferences.setDouble(key, value) ?? 0.0;
            break;
          case int:
            return sharedPreferences.setInt(key, value) ?? 0;
            break;
          case List:
            return sharedPreferences.setStringList(key, value) ?? [];
            break;
          case bool:
            return sharedPreferences.setBool(key, value) ?? false;
            break;
          default:
            return sharedPreferences.setString(key, value) ?? '';
            break;
        }
      },
    );
  }
}
