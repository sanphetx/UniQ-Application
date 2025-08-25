import 'package:hive_flutter/adapters.dart';
import 'package:core/src/models/token.dart';
import 'package:core/src/utils/file_operation_util.dart';

class HiveManager {
  HiveManager(this._hive, this._fileOperationUtil);

  final HiveInterface _hive;
  late final FileOperationUtil _fileOperationUtil;
  String get _subDirectory => 'hive';

  Future<void> init() async {
    await _open();
    registerAdapters();
  }

  Future<void> clear() async {
    await _hive.deleteFromDisk();
    await _fileOperationUtil.removeSubDirectory(_subDirectory);
  }

  Future<void> _open() async {
    final subPath = await _fileOperationUtil.createSubDirectory(_subDirectory);
    await _hive.initFlutter(subPath);
  }

  void registerAdapters() {
    _hive.registerAdapter(TokenModelAdapter());
  }
}
