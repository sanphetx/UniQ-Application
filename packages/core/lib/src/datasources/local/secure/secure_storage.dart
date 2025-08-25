import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:core/src/extensions/string_extension.dart';

class SecureStorage<T> {
  SecureStorage(this._secureStorage);
  final FlutterSecureStorage _secureStorage;

  Future<T?> get(String key) async {
    try {
      final response = await _secureStorage.read(key: key);
      if (response == null || response.isEmpty) {
        return null;
      }

      return response.tryParse<T>();
    } catch (e) {
      await _secureStorage.deleteAll();
      return null;
    }
  }

  Future<void> set(String key, {required T data}) async {
    try {
      await _secureStorage.write(key: key, value: data.toString());
    } catch (e) {
      await _secureStorage.deleteAll();
      await _secureStorage.write(key: key, value: data.toString());
    }
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }
}
