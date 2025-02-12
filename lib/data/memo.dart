import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo.freezed.dart';
part 'memo.g.dart';

@freezed
class Memo with _$Memo {
  const factory Memo({
    required String memoId,
    required DateTime date,
    required String title,
    required String text,
    String? historyId,
  }) = _Memo;

  const Memo._();

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);
}
