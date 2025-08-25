import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:core/src/datasources/local/secure/secure_storage.dart';

class HiveEncryption {
  HiveEncryption(this._hive, this._secureStorage);

  final HiveInterface _hive;
  final SecureStorage<String> _secureStorage;

  @visibleForTesting
  Uint8List? encryptionKey;

  final String _key = 'encryption_key';

  Future<Uint8List> getSecureKey() async {
    if (this.encryptionKey != null) {
      return this.encryptionKey!;
    }

    var encryptionKeyString = await _secureStorage.get(_key);
    if (encryptionKeyString == null) {
      final key = _hive.generateSecureKey();
      await _secureStorage.set(_key, data: base64UrlEncode(key));

      encryptionKeyString = await _secureStorage.get(_key);
    }

    final encryptionKey = base64Url.decode(encryptionKeyString!);
    this.encryptionKey = encryptionKey;
    return encryptionKey;
  }
}
