import 'package:json_annotation/json_annotation.dart';

part 'memo_line.g.dart';

@JsonSerializable()
class MemoLine {
  final int tab;
  final String value;

  MemoLine({required this.tab, required this.value});

  factory MemoLine.fromJson(Map<String, dynamic> json) =>
      _$MemoLineFromJson(json);

  Map<String, dynamic> toJson() => _$MemoLineToJson(this);
}
