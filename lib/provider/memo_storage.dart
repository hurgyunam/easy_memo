import 'dart:convert';

import 'package:easy_memo/data/memo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

final memoStorageProvider = Provider((ref) => MemoStorage());

class MemoStorage {
  final storage = const FlutterSecureStorage();
  final idGenerator = const Uuid();

  Future<String?> saveMemo({
    required DateTime date,
    required String title,
    required String text,
    String? memoId,
    String? historyId,
    String? rootMemoId,
  }) async {
    final key = "memo:$memoId";

    Memo? memo;

    if (memoId != null) {
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
      memo = Memo(
        memoId: idGenerator.v4(),
        date: date,
        title: title,
        text: text,
        historyId: historyId,
      );
    }

    if (memo != null) {
      _addMemoDateId(date: date, memoId: memo.memoId);

      if (historyId != null) {
        final result =
            await _addMemoHistoryId(historyId: historyId, memoId: memo.memoId);

        if (result) {
          memo = memo.copyWith(historyId: historyId);
        } else {
          //TODO: crashlytics
          memo = null;
        }
      } else if (rootMemoId != null) {
        final newHistoryId = await _createMemoHistory(
            memoId: memo.memoId, rootMemoId: rootMemoId);

        memo = memo.copyWith(historyId: newHistoryId);
      }

      if (memo != null) {
        // 메모를 저장하려던 중에 에러가 발생
        storage.write(key: key, value: jsonEncode(memo.toJson()));

        return memo.memoId;
      } else {
        //TODO: crashlytics
        return null;
      }
    } else {
      //TODO: crashlytics
      return null;
    }
  }

  Future<bool> _addMemoDateId({
    required DateTime date,
    required String memoId,
  }) async {
    final zeroDate = date.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
    final key = "date:$zeroDate";

    final json = await storage.read(key: key);

    if (json != null) {
      Set<String>? memoIds = jsonDecode(json);
      Set<String> newMemoIds;

      if (memoIds == null) {
        newMemoIds = {memoId};
      } else {
        newMemoIds = {...memoIds, memoId};
      }

      await storage.write(key: key, value: jsonEncode(newMemoIds));

      return true;
    } else {
      //TODO: crashlytics
      return false;
    }
  }

  Future<bool> _addMemoHistoryId({
    required String historyId,
    required String memoId,
  }) async {
    final key = "history:$historyId";
    final json = await storage.read(key: key);

    if (json != null) {
      Set<String>? memoIds = jsonDecode(json);
      Set<String> newMemoIds;

      if (memoIds == null) {
        newMemoIds = {memoId};
      } else {
        newMemoIds = {...memoIds, memoId};
      }

      await storage.write(key: key, value: jsonEncode(newMemoIds));

      return true;
    } else {
      //TODO: crashlytics
      return false;
    }
  }

  Future<String> _createMemoHistory({
    required String memoId,
    required String rootMemoId,
  }) async {
    final newId = idGenerator.v4();
    final key = "history:$newId";

    final history = {rootMemoId, memoId};
    await storage.write(key: key, value: jsonEncode(history));

    return newId;
  }
}
