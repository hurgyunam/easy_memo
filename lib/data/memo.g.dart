// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemoImpl _$$MemoImplFromJson(Map<String, dynamic> json) => _$MemoImpl(
      memoId: json['memoId'] as String,
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      text: json['text'] as String,
      historyId: json['historyId'] as String?,
    );

Map<String, dynamic> _$$MemoImplToJson(_$MemoImpl instance) =>
    <String, dynamic>{
      'memoId': instance.memoId,
      'date': instance.date.toIso8601String(),
      'title': instance.title,
      'text': instance.text,
      'historyId': instance.historyId,
    };
