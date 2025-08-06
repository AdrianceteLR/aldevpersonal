// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_movement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FinanceMovementImpl _$$FinanceMovementImplFromJson(
  Map<String, dynamic> json,
) => _$FinanceMovementImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  amount: (json['amount'] as num).toDouble(),
  type: $enumDecode(_$MovementTypeEnumMap, json['type']),
  category: json['category'] as String,
  date: DateTime.parse(json['date'] as String),
  description: json['description'] as String?,
);

Map<String, dynamic> _$$FinanceMovementImplToJson(
  _$FinanceMovementImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'amount': instance.amount,
  'type': _$MovementTypeEnumMap[instance.type]!,
  'category': instance.category,
  'date': instance.date.toIso8601String(),
  'description': instance.description,
};

const _$MovementTypeEnumMap = {
  MovementType.income: 'income',
  MovementType.expense: 'expense',
};
