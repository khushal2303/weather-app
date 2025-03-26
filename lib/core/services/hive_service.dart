import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static HiveService? _instance;

  factory HiveService() {
    _instance ??= HiveService._();
    return _instance!;
  }

  HiveService._();

  // Init hive service and open all boxes
  Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    log(appDocumentDir.path);
    Hive.init(appDocumentDir.path);

    final key = await getEncryptionKey();

    for (final box in HiveBox.values) {
      await Hive.openBox(
        box.boxName,
        encryptionCipher: key != null ? HiveAesCipher(key) : null,
      );
    }

    // Hive.registerAdapter(PermissionsDataAdapter());
  }

  // Get box method
  Box<dynamic> getBox(HiveBox box) {
    return Hive.box(
      box.boxName,
    );
  }

  // Save value to box
  Future<void> addData<T>(
    HiveKey key,
    dynamic data, {
    HiveBox box = HiveBox.weather,
  }) async {
    final bx = getBox(key.box);
    await bx.put(key.name, data);
  }

  // Get value from box
  dynamic getData<T>(
    HiveKey key, {
    dynamic defaultValue,
  }) {
    final bx = getBox(key.box);
    return bx.get(
      key.name,
      defaultValue: defaultValue,
    );
  }

  // Clear box
  Future<int> clear(
    HiveBox box,
  ) async {
    final bx = getBox(box);
    return bx.clear();
  }

  // Encryption to store data
  Future<Uint8List?> getEncryptionKey() async {
    const secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
    try {
      // if key not exists return null
      final encryptionKey = await secureStorage.read(key: 'key');
      if (encryptionKey == null) {
        final key = Hive.generateSecureKey();
        await secureStorage.write(
          key: 'key',
          value: base64UrlEncode(key),
        );
      }
      final key = await secureStorage.read(key: 'key');
      final encryptionKeyNew = base64Url.decode(key!);
      return encryptionKeyNew;
    } catch (e) {
      return null;
    }
  }
}

// Types of hive box
enum HiveBox { weather }

// extension for get box name
extension HiveBoxHelpers on HiveBox {
  String get boxName {
    switch (this) {
      case HiveBox.weather:
        return 'weather';
    }
  }
}

// Types of hive key to store and get data
enum HiveKey {
  //Features
  weatherData,
  themeMode,
}

// Get hive box based on hive key
extension HiveKeyHelpers on HiveKey {
  HiveBox get box {
    switch (this) {
      case HiveKey.weatherData:
      case HiveKey.themeMode:
        return HiveBox.weather;
    }
  }
}
