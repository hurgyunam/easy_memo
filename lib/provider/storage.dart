import 'dart:convert';

import 'package:easy_memo/data/ui/memo.dart';
import 'package:easy_memo/data/ui/memo_line.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storageProvider = Provider<Storage>((ref) {
  return Storage();
});

const constDateKey = "dates";

class Storage {
  final secureStorage = const FlutterSecureStorage();

  Future<void> readMemosByDate() async {
    final String? datesMapStr = await secureStorage.read(key: constDateKey);
  }

  void readMemosByCategory() {}

  /**
   * TODO: ID로 UUID가짐. 이를 함수에서 반환
   * category => {'abc': ['uuid1', 'uuid3'], 'efd': 'uuid2'}
   * date => {'2024-12-21': ['uuid4', 'uuid5']}
   * memo_uuid4 => {id: 'uuid4', category: 'abc', date: '2024-12-21', memos: [{text: 'sadfjkl', tab: 1}]}
   */
  Future<String> writeMemo(List<MemoLine> memoLines) async {
    final memo = Memo(memoLines: memoLines, date: DateTime.now());

    await _writeDatesMap(memo.dateKey, memo.id);

    final result = jsonEncode(memo);

    secureStorage.write(key: memo.storageKey, value: result);

    return memo.id;
  }

  Future<Map<String, Set<String>>> _writeDatesMap(
      String dateKey, String memoId) async {
    Map<String, Set<String>> datesMap = await _readDatesMap();

    Set<String>? memoIds = datesMap[dateKey];

    if (memoIds != null) {
      memoIds.add(memoId);
      datesMap[dateKey] = memoIds;
    } else {
      datesMap[dateKey] = <String>{memoId};
    }

    secureStorage.write(key: dateKey, value: jsonEncode(datesMap));

    return datesMap;
  }

  Future<Map<String, Set<String>>> _readDatesMap() async {
    final String? datesMapStr = await secureStorage.read(key: constDateKey);

    final Map<String, Set<String>> result = {};

    if (datesMapStr != null) {
      final obj = jsonDecode(datesMapStr);

      if (obj is Map) {
        for (final key in obj.keys) {
          final element = obj[key];

          if (element is List) {
            result.putIfAbsent(
                key, () => element.map((e) => e.toString()).toSet());
          }
        }
      }
    }

    return result;
  }
}
