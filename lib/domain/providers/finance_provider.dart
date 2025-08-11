import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/finance/finance_movement_model.dart';
import '../../services/finance/finance_service.dart';
import '../../widgets/enhanced_bar_chart.dart';
import '../../widgets/expense_chart.dart';
import 'auth_provider.dart';

final financeServiceProvider = Provider<FinanceService>((ref) => FinanceService());

final financeMovementsProvider = StreamProvider<List<FinanceMovement>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  
  return ref.watch(financeServiceProvider).getMovements(user.uid);
});

final selectedPeriodProvider = StateProvider<String>((ref) => 'Este mes');

final financeSummaryProvider = FutureProvider<Map<String, double>>((ref) async {
  final user = ref.watch(currentUserProvider);
  final period = ref.watch(selectedPeriodProvider);
  if (user == null) return {'income': 0, 'expense': 0, 'balance': 0};
  
  return ref.watch(financeServiceProvider).getFinancialSummary(user.uid, period);
});

final monthlyChartDataProvider = FutureProvider<Map<String, List<double>>>((ref) async {
  final user = ref.watch(currentUserProvider);
  final period = ref.watch(selectedPeriodProvider);
  if (user == null) return {'income': [], 'expense': []};
  
  return ref.watch(financeServiceProvider).getMonthlyData(user.uid, period);
});

final categoryChartDataProvider = FutureProvider<Map<String, double>>((ref) async {
  final user = ref.watch(currentUserProvider);
  final period = ref.watch(selectedPeriodProvider);
  if (user == null) return {};
  
  return ref.watch(financeServiceProvider).getCategoryExpenses(user.uid, period);
});

final financeActionsProvider = Provider<FinanceActions>((ref) {
  return FinanceActions(ref);
});

class FinanceActions {
  final Ref _ref;
  
  FinanceActions(this._ref);

  Future<void> addMovement({
    required String title,
    required double amount,
    required MovementType type,
    required MovementCategory category,
    String? description,
    DateTime? date,
  }) async {
    final user = _ref.read(currentUserProvider);
    if (user == null) throw Exception('Usuario no autenticado');

    final movement = FinanceMovement(
      id: '',
      userId: user.uid,
      title: title,
      amount: amount,
      type: type,
      category: category,
      description: description,
      date: date ?? DateTime.now(),
    );

    await _ref.read(financeServiceProvider).addMovement(movement);
  }

  Future<void> updateMovement(FinanceMovement movement) async {
    await _ref.read(financeServiceProvider).updateMovement(movement);
  }

  Future<void> deleteMovement(String movementId) async {
    await _ref.read(financeServiceProvider).deleteMovement(movementId);
  }
}