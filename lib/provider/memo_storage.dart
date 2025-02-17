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
    required String title,
    required String content,
    required DateTime date, // 수정할 때는 사용되지 않음
    String? memoId, // 수정 할 때 id
    String? historyId, // 기존 히스토리에 추가할 때
    String? rootMemoId, // 처음 히스토리를 만들 때
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

  Future<List<Memo>> loadByDate({
    required DateTime date,
  }) async {
    return loadMemoAction.loadByDate(date: date, storage: storage);
  }

  Future<Memo?> loadByMemoId({
    required String memoId,
  }) async {
    return loadMemoAction.loadByMemoId(memoId: memoId, storage: storage);
  }

  Future<List<Memo>> loadByHistoryId({
    required String historyId,
  }) async {
    return loadMemoAction.loadByHistoryId(
        historyId: historyId, storage: storage);
  }
}
