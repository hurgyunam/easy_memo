// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoLine _$MemoLineFromJson(Map<String, dynamic> json) => MemoLine(
      tab: (json['tab'] as num).toInt(),
      value: json['value'] as String,
    );

Map<String, dynamic> _$MemoLineToJson(MemoLine instance) => <String, dynamic>{
      'tab': instance.tab,
      'value': instance.value,
    };
