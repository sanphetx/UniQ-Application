import 'package:hive_flutter/adapters.dart';

import 'package:core/src/datasources/local/hive/hive_encryption.dart';

/// Abstract interface for performing CRUD operations on Hive database boxes.
///
/// This interface provides a type-safe way to interact with Hive storage,
/// supporting encrypted data persistence with automatic box management.
/// The box will be automatically opened if not already initialized when
/// calling any operation.
///
/// Type parameter [T] represents the data model type that will be stored
/// and retrieved from the Hive box.
///
/// Example usage:
/// ```dart
/// final userOperation = HiveOperationImpl<User>(hive, encryption);
/// await userOperation.startBox();
/// await userOperation.insertOrUpdateItem('user_1', user);
/// final retrievedUser = await userOperation.getItem('user_1');
/// ```
abstract class HiveOperation<T> {
  /// Initializes and opens the Hive box for this operation.
  ///
  /// This method must be called before performing any other operations.
  /// It handles box opening with encryption and ensures the box is ready
  /// for data operations. If the box is already open, this method returns
  /// immediately without performing any action.
  ///
  /// Throws [HiveError] if the box cannot be opened or initialized.
  Future<void> startBox();

  /// Inserts or updates a single item in the Hive box.
  ///
  /// [key] - Unique identifier for the item
  /// [model] - The data model to store
  ///
  /// If an item with the same key already exists, it will be overwritten.
  /// The box will be automatically opened if not already initialized.
  ///
  /// Example:
  /// ```dart
  /// await operation.insertOrUpdateItem('user_123', userModel);
  /// ```
  Future<void> insertOrUpdateItem(String key, T model);

  /// Inserts or updates multiple items in the Hive box in a single operation.
  ///
  /// [keys] - List of unique identifiers for the items
  /// [models] - List of data models to store
  ///
  /// The [keys] and [models] lists must have the same length, with each
  /// key corresponding to the model at the same index. This method is more
  /// efficient than multiple individual insert operations.
  ///
  /// Throws [ArgumentError] if the keys and models lists have different lengths.
  ///
  /// Example:
  /// ```dart
  /// await operation.insertOrUpdateItems(
  ///   ['user_1', 'user_2'],
  ///   [userModel1, userModel2]
  /// );
  /// ```
  Future<void> insertOrUpdateItems(List<String> keys, List<T> models);

  /// Retrieves a single item from the Hive box by its key.
  ///
  /// [key] - The unique identifier of the item to retrieve
  ///
  /// Returns the stored model if found, or `null` if no item exists
  /// with the specified key. The box will be automatically opened
  /// if not already initialized.
  ///
  /// Example:
  /// ```dart
  /// final user = await operation.getItem('user_123');
  /// if (user != null) {
  ///   print('Found user: ${user.name}');
  /// }
  /// ```
  Future<T?> getItem(String key);

  /// Retrieves all items stored in the Hive box.
  ///
  /// Returns a list containing all stored models. The list will be empty
  /// if no items are stored in the box. The order of items in the returned
  /// list is not guaranteed to match insertion order.
  ///
  /// The box will be automatically opened if not already initialized.
  ///
  /// Example:
  /// ```dart
  /// final allUsers = await operation.getAllItems();
  /// print('Total users: ${allUsers.length}');
  /// ```
  Future<List<T>> getAllItems();

  /// Deletes a single item from the Hive box by its key.
  ///
  /// [key] - The unique identifier of the item to delete
  ///
  /// If no item exists with the specified key, this method completes
  /// without error. The box will be automatically opened if not
  /// already initialized.
  ///
  /// Example:
  /// ```dart
  /// await operation.deleteItem('user_123');
  /// ```
  Future<void> deleteItem(String key);

  /// Deletes all items from the Hive box.
  ///
  /// This operation clears the entire box, removing all stored data.
  /// Use with caution as this action cannot be undone. The box will
  /// be automatically opened if not already initialized.
  ///
  /// Example:
  /// ```dart
  /// await operation.deleteAllItems();
  /// ```
  Future<void> deleteAllItems();
}

class HiveOperationImpl<T> implements HiveOperation<T> {
  HiveOperationImpl(this._hive, this._encryption);

  late final HiveEncryption _encryption;
  late final HiveInterface _hive;
  final String _key = T.toString();
  Box<T>? _box;

  @override
  Future<void> startBox() async {
    if (_hive.isBoxOpen(_key)) {
      return;
    }

    final encryptionKey = await _encryption.getSecureKey();
    _box = await _hive.openBox<T>(_key, encryptionCipher: HiveAesCipher(encryptionKey));
  }

  @override
  Future<void> insertOrUpdateItem(String key, T model) => _run<void>(() async {
    await _box!.put(key, model);
  });

  @override
  Future<void> insertOrUpdateItems(List<String> keys, List<T> models) => _run<void>(() async {
    if (keys.length != models.length) {
      throw ArgumentError('Number of keys and models should be the same');
    }

    final map = Map.fromIterables(keys, models);
    await _box!.putAll(map);
  });

  @override
  Future<T?> getItem(String key) => _run<T?>(() async {
    return _box!.get(key);
  });

  @override
  Future<List<T>> getAllItems() => _run<List<T>>(() async {
    return _box!.values.toList();
  });

  @override
  Future<void> deleteItem(String key) => _run<void>(() async {
    await _box!.delete(key);
  });

  @override
  Future<void> deleteAllItems() => _run<void>(() async {
    await _box!.clear();
  });

  Future<U> _run<U>(Future<U> Function() operation) async {
    if (_box == null) {
      await startBox();
    }
    return operation();
  }
}
