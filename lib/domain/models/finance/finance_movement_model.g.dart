// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_movement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FinanceMovementImpl _$$FinanceMovementImplFromJson(
  Map<String, dynamic> json,
) => _$FinanceMovementImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  title: json['title'] as String,
  amount: (json['amount'] as num).toDouble(),
  type: $enumDecode(_$MovementTypeEnumMap, json['type']),
  category: $enumDecode(_$MovementCategoryEnumMap, json['category']),
  description: json['description'] as String?,
  date: DateTime.parse(json['date'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$FinanceMovementImplToJson(
  _$FinanceMovementImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'amount': instance.amount,
  'type': _$MovementTypeEnumMap[instance.type]!,
  'category': _$MovementCategoryEnumMap[instance.category]!,
  'description': instance.description,
  'date': instance.date.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$MovementTypeEnumMap = {
  MovementType.income: 'income',
  MovementType.expense: 'expense',
};

const _$MovementCategoryEnumMap = {
  MovementCategory.salary: 'salary',
  MovementCategory.freelance: 'freelance',
  MovementCategory.investment: 'investment',
  MovementCategory.gift: 'gift',
  MovementCategory.other_income: 'other_income',
  MovementCategory.food: 'food',
  MovementCategory.transport: 'transport',
  MovementCategory.entertainment: 'entertainment',
  MovementCategory.health: 'health',
  MovementCategory.shopping: 'shopping',
  MovementCategory.bills: 'bills',
  MovementCategory.rent: 'rent',
  MovementCategory.other_expense: 'other_expense',
};
