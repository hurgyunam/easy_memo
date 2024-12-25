import 'package:easy_memo/data/ui/memo_line.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'memo.g.dart';

const uuidBuilder = Uuid();
final dateFormat = DateFormat("yyyy-MM-dd");

@JsonSerializable()
class Memo {
  final String id;
  final List<MemoLine> memoLines;
  final DateTime date;
  final String title;

  Memo({required this.memoLines, required this.date, String? id})
      : id = id ?? uuidBuilder.v4(),
        title = memoLines.isNotEmpty ? memoLines[0].value : "EMPTY";

  get storageKey {
    return "memo_$id";
  }

  get dateKey {
    return dateFormat.format(date);
  }

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);

  Map<String, dynamic> toJson() => _$MemoToJson(this);
}
