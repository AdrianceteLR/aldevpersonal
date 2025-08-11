// ignore_for_file: unused_result

import 'package:aldevpersonal/presentation/theme/app_colors.dart';
import 'package:aldevpersonal/widgets/category_progress_card.dart';
import 'package:aldevpersonal/widgets/enhanced_bar_chart.dart';
import 'package:aldevpersonal/widgets/expense_chart.dart';
import 'package:aldevpersonal/widgets/filter_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/providers/finance_provider.dart';
import 'components_finances/finances_header.dart';
import 'components_finances/quick_actions_section.dart';
import 'components_finances/recent_movements_section.dart';
import 'components_finances/finances_dialogs.dart';
class FinancesView extends ConsumerStatefulWidget {
  const FinancesView({super.key});

  @override
  ConsumerState<FinancesView> createState() => _FinancesViewState();
}

class _FinancesViewState extends ConsumerState<FinancesView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedPeriod = ref.watch(selectedPeriodProvider);
    final movementsAsync = ref.watch(financeMovementsProvider);
    final summaryAsync = ref.watch(financeSummaryProvider);
    final monthlyDataAsync = ref.watch(monthlyChartDataProvider);
    final categoryDataAsync = ref.watch(categoryChartDataProvider);
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              summaryAsync.when(
                data: (summary) => FinancesHeader(
                  selectedPeriod: selectedPeriod,
                  isDark: isDark,
                  balance: summary['balance'] ?? 0,
                  income: summary['income'] ?? 0,
                  expense: summary['expense'] ?? 0,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => FinancesHeader(
                  selectedPeriod: selectedPeriod,
                  isDark: isDark,
                  balance: 0,
                  income: 0,
                  expense: 0,
                ),
              ),
              const SizedBox(height: 16),
              _buildPeriodFilter(),
              const SizedBox(height: 20),
              QuickActionsSection(
                isDark: isDark,
                onAddIncome: () => FinancesDialogs.showAddMovementDialog(context, ref, isIncome: true),
                onAddExpense: () => FinancesDialogs.showAddMovementDialog(context, ref, isIncome: false),
                onTransfer: () {},
                onExport: () => FinancesDialogs.showExportDialog(context),
              ),
              const SizedBox(height: 20),
              monthlyDataAsync.when(
                data: (data) => EnhancedBarChart(
                  incomeData: _convertToBarData(data['income'] ?? []),
                  expenseData: _convertToBarData(data['expense'] ?? []),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => EnhancedBarChart(
                  incomeData: _getMockBarIncomeData(),
                  expenseData: _getMockBarExpenseData(),
                ),
              ),
              const SizedBox(height: 20),
              categoryDataAsync.when(
                data: (data) => ExpenseChart(data: _convertToPieData(data)),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => ExpenseChart(data: _getMockChartData()),
              ),
              const SizedBox(height: 20),
              _buildCategoryProgress(isDark),
              const SizedBox(height: 20),
              movementsAsync.when(
                data: (movements) => RecentMovementsSection(
                  isDark: isDark,
                  movements: movements.take(5).toList(),
                  onEdit: (movement) => FinancesDialogs.showEditMovementDialog(context, ref, movement),
                  onDelete: (movementId) => _deleteMovement(movementId),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => FinancesDialogs.showAddMovementDialog(context, ref),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: AppColors.textPrimary),
        label: const Text('Agregar', style: TextStyle(color: AppColors.textPrimary)),
      ),
    );
  }



  Widget _buildPeriodFilter() {
    final selectedPeriod = ref.watch(selectedPeriodProvider);
    return FilterChips(
      options: const ['Esta semana', 'Este mes', 'Este año'],
      selectedOption: selectedPeriod,
      onSelected: (period) {
        ref.read(selectedPeriodProvider.notifier).state = period;
      },
    );
  }



  Widget _buildCategoryProgress(bool isDark) {
    final categoryDataAsync = ref.watch(categoryChartDataProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progreso por Categoría',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? AppColors.textPrimary : Colors.black87),
        ),
        const SizedBox(height: 12),
        categoryDataAsync.when(
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Text(
                  'No hay datos de categorías',
                  style: TextStyle(color: isDark ? AppColors.textSecondary : Colors.black54),
                ),
              );
            }
            
            final sortedEntries = data.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value));
            
            return Column(
              children: sortedEntries.take(3).map((entry) {
                final budget = entry.value * 1.3; // Presupuesto estimado 30% más
                final progress = entry.value / budget;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CategoryProgressCard(
                    category: _getCategoryDisplayName(entry.key),
                    spent: '${entry.value.toStringAsFixed(0)}€',
                    budget: '${budget.toStringAsFixed(0)}€',
                    progress: progress.clamp(0.0, 1.0),
                    icon: _getCategoryIcon(entry.key),
                    color: _getCategoryColor(entry.key),
                  ),
                );
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => Center(
            child: Text(
              'Error al cargar categorías',
              style: TextStyle(color: isDark ? AppColors.textSecondary : Colors.black54),
            ),
          ),
        ),
      ],
    );
  }



  Future<void> _handleRefresh() async {
    ref.refresh(financeMovementsProvider);
    ref.refresh(financeSummaryProvider);
    ref.refresh(monthlyChartDataProvider);
    ref.refresh(categoryChartDataProvider);
  }

  Future<void> _deleteMovement(String movementId) async {
    try {
      await ref.read(financeActionsProvider).deleteMovement(movementId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }



  List<BarData> _getMockBarIncomeData() {
    return [
      BarData(month: 'Ene', value: 2500),
      BarData(month: 'Feb', value: 2800),
      BarData(month: 'Mar', value: 2600),
      BarData(month: 'Abr', value: 3200),
      BarData(month: 'May', value: 2900),
      BarData(month: 'Jun', value: 3100),
    ];
  }

  List<BarData> _getMockBarExpenseData() {
    return [
      BarData(month: 'Ene', value: 1800),
      BarData(month: 'Feb', value: 2100),
      BarData(month: 'Mar', value: 1900),
      BarData(month: 'Abr', value: 2200),
      BarData(month: 'May', value: 1700),
      BarData(month: 'Jun', value: 2000),
    ];
  }

  List<ChartData> _getMockChartData() {
    return [
      ChartData(label: 'Alimentación', value: 450, percentage: 35, color: AppColors.primary),
      ChartData(label: 'Transporte', value: 200, percentage: 15, color: AppColors.success),
      ChartData(label: 'Entretenimiento', value: 150, percentage: 12, color: AppColors.accent),
      ChartData(label: 'Servicios', value: 300, percentage: 23, color: AppColors.danger),
      ChartData(label: 'Otros', value: 200, percentage: 15, color: AppColors.primaryDark),
    ];
  }

  List<BarData> _convertToBarData(List<double> data) {
    final months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'];
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

  List<ChartData> _convertToPieData(Map<String, double> categoryData) {
    if (categoryData.isEmpty) return _getMockChartData();
    
    final total = categoryData.values.fold(0.0, (sum, value) => sum + value);
    final colors = [AppColors.primary, AppColors.success, AppColors.accent, AppColors.danger, AppColors.primaryDark];
    
    return categoryData.entries.take(5).toList().asMap().entries.map((entry) {
      final index = entry.key;
      final categoryEntry = entry.value;
      final percentage = ((categoryEntry.value / total) * 100);
      
      return ChartData(
        label: _getCategoryDisplayName(categoryEntry.key),
        value: categoryEntry.value,
        percentage: percentage.toDouble(),
        color: colors[index % colors.length],
      );
    }).toList();
  }

  String _getCategoryDisplayName(String category) {
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

  IconData _getCategoryIcon(String category) {
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'food': return AppColors.primary;
      case 'transport': return AppColors.accent;
      case 'entertainment': return AppColors.danger;
      case 'health': return AppColors.success;
      case 'shopping': return AppColors.primaryDark;
      default: return AppColors.primary;
    }
  }
}