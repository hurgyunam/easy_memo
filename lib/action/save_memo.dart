import 'dart:convert';

import 'package:easy_memo/data/memo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// 기능 컴포넌트
class SaveMemoAction {
  final dateFormat = DateFormat("yyyy-MM-dd");
  final idGenerator = const Uuid();

  Future<String?> saveMemo({
    required DateTime date,
    required String title,
    required String text,
    String? memoId,
    String? historyId,
    String? rootMemoId,
    required FlutterSecureStorage storage,
  }) async {
    String key;

    Memo? memo;

    if (memoId != null) {
      key = "memo:$memoId";
      String? raw = await storage.read(key: key);

      if (raw != null) {
        final Map<String, dynamic> json = jsonDecode(raw);
        final parsedMemo = Memo.fromJson(json);
        memo = parsedMemo.copyWith(
          title: title,
          text: text,
        );
      }
    } else {
      final newId = idGenerator.v4();
      key = "memo:$newId";
      memo = Memo(
        memoId: newId,
        date: date,
        title: title,
        text: text,
        historyId: historyId,
      );
    }

    if (memo != null) {
      _addMemoDateId(date: date, memoId: memo.memoId, storage: storage);

      if (historyId != null) {
        final result = await _addMemoHistoryId(
            historyId: historyId, memoId: memo.memoId, storage: storage);

        if (result) {
          memo = memo.copyWith(historyId: historyId);
        } else {
          throw Exception("메모 저장 중 히스토리를 찾지 못했습니다: $historyId");
        }
      } else if (rootMemoId != null) {
        final newHistoryId = await _createMemoHistory(
            memoId: memo.memoId, rootMemoId: rootMemoId, storage: storage);

        memo = memo.copyWith(historyId: newHistoryId);

        await _addMemoHistoryId(
            historyId: newHistoryId,
            memoId: rootMemoId,
            storage: storage); // 새로 만든 히스토리에 rootMemo도 추가

        _updateRootMemo(
            rootMemoId: rootMemoId, historyId: newHistoryId, storage: storage);
      }

      await storage.write(key: key, value: jsonEncode(memo.toJson()));
      return memo.memoId;
    } else {
      throw Exception("메모 저장 중 기존 메모를 찾지 못했습니다: $key");
    }
  }

  Future<void> _updateRootMemo(
      {required String rootMemoId,
      required String historyId,
      required FlutterSecureStorage storage}) async {
    final key = "memo:$rootMemoId";
    String? raw = await storage.read(key: key);

    if (raw != null) {
      final Map<String, dynamic> json = jsonDecode(raw);
      final parsedMemo = Memo.fromJson(json);
      Memo memo = parsedMemo.copyWith(
        historyId: historyId,
      );
      await storage.write(key: key, value: jsonEncode(memo.toJson()));
    } else {
      throw Exception("히스토리 루트 메모 갱신 시도에 실패했습니다.: $key");
    }
  }

  Future<void> _addMemoDateId({
    required DateTime date,
    required String memoId,
    required FlutterSecureStorage storage,
  }) async {
    final zeroDate = date.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
    final key = "date:${dateFormat.format(zeroDate)}";

    final json = await storage.read(key: key);

    Set<String>? newMemoIds;

    if (json != null) {
      final List list = jsonDecode(json);
      final List<String> memoIds = list.cast<String>();

      Set<String>? oldMemoIds = memoIds.toSet();

      newMemoIds = {...oldMemoIds, memoId};
    }

    newMemoIds ??= {memoId};

    await storage.write(key: key, value: jsonEncode(newMemoIds.toList()));
  }

  Future<bool> _addMemoHistoryId({
    required String historyId,
    required String memoId,
    required FlutterSecureStorage storage,
  }) async {
    final key = "history:$historyId";
    final json = await storage.read(key: key);

    if (json != null) {
      List<String>? memoIds = jsonDecode(json).cast<String>();
      Set<String> newMemoIds;

      if (memoIds == null) {
        newMemoIds = {memoId};
      } else {
        newMemoIds = {...memoIds, memoId};
      }

      await storage.write(key: key, value: jsonEncode(newMemoIds.toList()));

      return true;
    } else {
      throw Exception("히스토리 정보를 불러오지 못했습니다: $key");
    }
  }

  Future<String> _createMemoHistory({
    required String memoId,
    required String rootMemoId,
    required FlutterSecureStorage storage,
  }) async {
    final newId = idGenerator.v4();
    final key = "history:$newId";

    final history = [rootMemoId, memoId];
    await storage.write(key: key, value: jsonEncode(history));

    return newId;
  }
}
