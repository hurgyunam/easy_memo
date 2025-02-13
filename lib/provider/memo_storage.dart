import 'package:easy_memo/action/load_memo.dart';
import 'package:easy_memo/action/save_memo.dart';
import 'package:easy_memo/data/memo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final memoStorageProvider = Provider((ref) => MemoStorage());

class MemoStorage {
  final FlutterSecureStorage storage;
  final SaveMemoAction saveMemoAction;
  final LoadMemoAction loadMemoAction;

  MemoStorage()
      : storage = const FlutterSecureStorage(),
        saveMemoAction = SaveMemoAction(),
        loadMemoAction = LoadMemoAction();

  Future readAll() {
    return storage.readAll();
  }

  Future<String?> saveMemo({
    required DateTime date,
    required String title,
    required String content,
    String? memoId,
    String? historyId,
    String? rootMemoId,
  }) async {
    return saveMemoAction.saveMemo(
        date: date,
        title: title,
        text: content,
        storage: storage,
        memoId: memoId,
        historyId: historyId,
        rootMemoId: rootMemoId);
  }

  Future<Set<Memo>> loadByDate({
    required DateTime date,
  }) async {
    storage.readAll().then((value) {
      print(value);
    });

    return loadMemoAction.loadByDate(date: date, storage: storage);
  }
}
