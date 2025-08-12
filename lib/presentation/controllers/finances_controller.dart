import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/providers/finance_provider.dart';
import '../../domain/models/finance/finance_movement_model.dart';
import '../../widgets/enhanced_bar_chart.dart';
import '../../widgets/expense_chart.dart';
import '../theme/app_colors.dart';

part 'finances_controller.g.dart';

@riverpod
class FinancesController extends _$FinancesController {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  String build() {
    return ref.watch(selectedPeriodProvider);
  }

  AsyncValue<List<FinanceMovement>> get movements => ref.watch(financeMovementsProvider);
  AsyncValue<Map<String, double>> get summary => ref.watch(financeSummaryProvider);
  AsyncValue<Map<String, List<double>>> get monthlyData => ref.watch(monthlyChartDataProvider);
  AsyncValue<Map<String, double>> get categoryData => ref.watch(categoryChartDataProvider);

  void changePeriod(String period) {
    ref.read(selectedPeriodProvider.notifier).state = period;
  }

  Future<void> handleRefresh() async {
    ref.refresh(financeMovementsProvider);
    ref.refresh(financeSummaryProvider);
    ref.refresh(monthlyChartDataProvider);
    ref.refresh(categoryChartDataProvider);
  }

  Future<void> deleteMovement(BuildContext context, String movementId) async {
    try {
      await ref.read(financeActionsProvider).deleteMovement(movementId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  List<BarData> convertToBarData(List<double> data) {
    final now = DateTime.now();
    
    return List.generate(6, (index) {
      final monthDate = DateTime(now.year, now.month - (5 - index), 1);
      final monthName = _getMonthName(monthDate.month);
      return BarData(month: monthName, value: data.length > index ? data[index] : 0.0);
    });
  }

  String _getMonthName(int month) {
    const months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  List<ChartData> convertToPieData(Map<String, double> categoryData) {
    if (categoryData.isEmpty) return getMockChartData();
    
    final total = categoryData.values.fold(0.0, (sum, value) => sum + value);
    final colors = [AppColors.primary, AppColors.success, AppColors.accent, AppColors.danger, AppColors.primaryDark];
    
    return categoryData.entries.take(5).toList().asMap().entries.map((entry) {
      final index = entry.key;
      final categoryEntry = entry.value;
      final percentage = ((categoryEntry.value / total) * 100);
      
      return ChartData(
        label: getCategoryDisplayName(categoryEntry.key),
        value: categoryEntry.value,
        percentage: percentage.toDouble(),
        color: colors[index % colors.length],
      );
    }).toList();
  }

  String getCategoryDisplayName(String category) {
    switch (category) {
      case 'food': return 'Alimentación';
      case 'transport': return 'Transporte';
      case 'entertainment': return 'Entretenimiento';
      case 'health': return 'Salud';
      case 'shopping': return 'Compras';
      case 'bills': return 'Facturas';
      case 'rent': return 'Alquiler';
      default: return 'Otros';
    }
  }

  IconData getCategoryIcon(String category) {
    switch (category) {
      case 'food': return Icons.restaurant;
      case 'transport': return Icons.directions_car;
      case 'entertainment': return Icons.movie;
      case 'health': return Icons.local_hospital;
      case 'shopping': return Icons.shopping_cart;
      case 'bills': return Icons.receipt;
      case 'rent': return Icons.home;
      default: return Icons.account_balance_wallet;
    }
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case 'food': return AppColors.primary;
      case 'transport': return AppColors.accent;
      case 'entertainment': return AppColors.danger;
      case 'health': return AppColors.success;
      case 'shopping': return AppColors.primaryDark;
      default: return AppColors.primary;
    }
  }

  List<BarData> getMockBarIncomeData() {
    return [
      BarData(month: 'Ene', value: 2500),
      BarData(month: 'Feb', value: 2800),
      BarData(month: 'Mar', value: 2600),
      BarData(month: 'Abr', value: 3200),
      BarData(month: 'May', value: 2900),
      BarData(month: 'Jun', value: 3100),
    ];
  }

  List<BarData> getMockBarExpenseData() {
    return [
      BarData(month: 'Ene', value: 1800),
      BarData(month: 'Feb', value: 2100),
      BarData(month: 'Mar', value: 1900),
      BarData(month: 'Abr', value: 2200),
      BarData(month: 'May', value: 1700),
      BarData(month: 'Jun', value: 2000),
    ];
  }

  List<ChartData> getMockChartData() {
    return [
      ChartData(label: 'Alimentación', value: 450, percentage: 35, color: AppColors.primary),
      ChartData(label: 'Transporte', value: 200, percentage: 15, color: AppColors.success),
      ChartData(label: 'Entretenimiento', value: 150, percentage: 12, color: AppColors.accent),
      ChartData(label: 'Servicios', value: 300, percentage: 23, color: AppColors.danger),
      ChartData(label: 'Otros', value: 200, percentage: 15, color: AppColors.primaryDark),
    ];
  }
}

