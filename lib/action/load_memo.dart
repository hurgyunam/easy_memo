import 'dart:convert';

import 'package:easy_memo/data/memo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class LoadMemoAction {
  final dateFormat = DateFormat("yyyy-MM-dd");
  Future<Set<Memo>> loadByDate({
    required DateTime date,
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

    if (json != null) {
      Set<String>? memoIds = jsonDecode(json);

      if (memoIds != null) {
        Set<Memo> memos = {};

        for (String memoId in memoIds) {
          final memoKey = "memo:$memoId";
          final memoJson = await storage.read(key: memoKey);

          if (memoJson != null) {
            memos.add(Memo.fromJson(jsonDecode(memoJson)));
          }
        }

        return memos;
      }
    }

    return {};
  }
  /**
   * function readByDates(Date date): List<Memo> {
      List<String> memoIds = storage.read(`date:${date}`);
      List<Memo> result = [];

      for(String memoId in memoIds) {
      Memo memo = storage.read(`memo:${memoId}`);

      result.add(memo);
      }

      return result;
      }

      function readByHistoryId(String historyId): List<Memo> {
      List<String> memoIds = storage.read(`history:${historyId}`);
      List<Memo> result = [];

      for(String memoId in memoIds) {
      Memo memo = storage.read(`memo:${memoId}`);

      result.add(memo);
      }

      return result;
      }
   */
}
