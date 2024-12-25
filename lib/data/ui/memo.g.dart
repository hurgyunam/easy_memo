// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Memo _$MemoFromJson(Map<String, dynamic> json) => Memo(
      memoLines: (json['memoLines'] as List<dynamic>)
          .map((e) => MemoLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$MemoToJson(Memo instance) => <String, dynamic>{
      'id': instance.id,
      'memoLines': instance.memoLines,
      'date': instance.date.toIso8601String(),
    };
