import 'dart:convert';

import 'package:easy_memo/data/memo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class LoadMemoAction {
  final dateFormat = DateFormat("yyyy-MM-dd");

  Future<Memo?> loadByMemoId({
    required String memoId,
    required FlutterSecureStorage storage,
  }) async {
    final key = "memo:$memoId";

    final json = await storage.read(key: key);

    if (json != null) {
      final Map<String, dynamic> map = jsonDecode(json);
      final Memo memo = Memo.fromJson(map);

      return memo;
    } else {
      return null;
    }
  }

  Future<List<Memo>> loadByDate({
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
      final List list = jsonDecode(json);
      Set<String>? memoIds = list.cast<String>().toSet();

      List<Memo> memos = [];

      for (String memoId in memoIds) {
        final memoKey = "memo:$memoId";
        final memoJson = await storage.read(key: memoKey);

        if (memoJson != null) {
          memos.add(Memo.fromJson(jsonDecode(memoJson)));
        }
      }

      return memos;
    } else {
      return [];
    }
  }

  Future<List<Memo>> loadByHistoryId({
    required String historyId,
    required FlutterSecureStorage storage,
  }) async {
    final key = "history:$historyId";

    final json = await storage.read(key: key);

    if (json != null) {
      final List list = jsonDecode(json);
      Set<String>? memoIds = list.cast<String>().toSet();

      List<Memo> memos = [];

      for (String memoId in memoIds) {
        final memoKey = "memo:$memoId";
        final memoJson = await storage.read(key: memoKey);

        if (memoJson != null) {
          memos.add(Memo.fromJson(jsonDecode(memoJson)));
        }
      }

      return memos;
    } else {
      return [];
    }
  }
}
