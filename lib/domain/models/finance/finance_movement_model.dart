import 'package:freezed_annotation/freezed_annotation.dart';

part 'finance_movement_model.freezed.dart';
part 'finance_movement_model.g.dart';

enum MovementType { income, expense }

enum MovementCategory {
  // Ingresos
  salary, freelance, investment, gift, other_income,
  // Gastos
  food, transport, entertainment, health, shopping, bills, rent, other_expense
}

@freezed
class FinanceMovement with _$FinanceMovement {
  const factory FinanceMovement({
    required String id,
    required String userId,
    required String title,
    required double amount,
    required MovementType type,
    required MovementCategory category,
    String? description,
    required DateTime date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FinanceMovement;

  factory FinanceMovement.fromJson(Map<String, dynamic> json) => _$FinanceMovementFromJson(json);
}

extension MovementCategoryExtension on MovementCategory {
  String get displayName {
    switch (this) {
      case MovementCategory.salary: return 'Salario';
      case MovementCategory.freelance: return 'Freelance';
      case MovementCategory.investment: return 'Inversión';
      case MovementCategory.gift: return 'Regalo';
      case MovementCategory.other_income: return 'Otros ingresos';
      case MovementCategory.food: return 'Comida';
      case MovementCategory.transport: return 'Transporte';
      case MovementCategory.entertainment: return 'Entretenimiento';
      case MovementCategory.health: return 'Salud';
      case MovementCategory.shopping: return 'Compras';
      case MovementCategory.bills: return 'Facturas';
      case MovementCategory.rent: return 'Alquiler';
      case MovementCategory.other_expense: return 'Otros gastos';
    }
  }

  bool get isIncome => [
    MovementCategory.salary,
    MovementCategory.freelance,
    MovementCategory.investment,
    MovementCategory.gift,
    MovementCategory.other_income,
  ].contains(this);
}