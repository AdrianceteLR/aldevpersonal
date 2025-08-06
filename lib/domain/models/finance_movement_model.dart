import 'package:freezed_annotation/freezed_annotation.dart';

part 'finance_movement_model.freezed.dart';
part 'finance_movement_model.g.dart';

@freezed
class FinanceMovement with _$FinanceMovement {
  const factory FinanceMovement({
    required String id,
    required String title,
    required double amount,
    required MovementType type,
    required String category,
    required DateTime date,
    String? description,
  }) = _FinanceMovement;

  factory FinanceMovement.fromJson(Map<String, dynamic> json) =>
      _$FinanceMovementFromJson(json);
}

enum MovementType {
  @JsonValue('income')
  income,
  @JsonValue('expense')
  expense,
}