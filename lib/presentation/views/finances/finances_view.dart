import 'package:aldevpersonal/presentation/theme/app_colors.dart';
import 'package:aldevpersonal/widgets/category_progress_card.dart';
import 'package:aldevpersonal/widgets/enhanced_bar_chart.dart';
import 'package:aldevpersonal/widgets/expense_chart.dart';
import 'package:aldevpersonal/widgets/filter_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  String selectedPeriod = 'Este mes';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
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
              FinancesHeader(
                selectedPeriod: selectedPeriod,
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              _buildPeriodFilter(),
              const SizedBox(height: 20),
              QuickActionsSection(
                isDark: isDark,
                onAddIncome: () => FinancesDialogs.showAddMovementDialog(context, isIncome: true),
                onAddExpense: () => FinancesDialogs.showAddMovementDialog(context, isIncome: false),
                onTransfer: () {},
                onExport: () => FinancesDialogs.showExportDialog(context),
              ),
              const SizedBox(height: 20),
              EnhancedBarChart(
                incomeData: _getMockBarIncomeData(),
                expenseData: _getMockBarExpenseData(),
              ),
              const SizedBox(height: 20),
              ExpenseChart(data: _getMockChartData()),
              const SizedBox(height: 20),
              _buildCategoryProgress(isDark),
              const SizedBox(height: 20),
              RecentMovementsSection(isDark: isDark),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => FinancesDialogs.showAddMovementDialog(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: AppColors.textPrimary),
        label: const Text('Agregar', style: TextStyle(color: AppColors.textPrimary)),
      ),
    );
  }



  Widget _buildPeriodFilter() {
    return FilterChips(
      options: const ['Esta semana', 'Este mes', 'Este año'],
      selectedOption: selectedPeriod,
      onSelected: (period) {
        setState(() {
          selectedPeriod = period;
        });
      },
    );
  }



  Widget _buildCategoryProgress(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progreso por Categoría',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? AppColors.textPrimary : Colors.black87),
        ),
        const SizedBox(height: 12),
        CategoryProgressCard(
          category: 'Alimentación',
          spent: '\$450',
          budget: '\$600',
          progress: 0.75,
          icon: Icons.restaurant,
          color: AppColors.primary,
        ),
        const SizedBox(height: 8),
        CategoryProgressCard(
          category: 'Transporte',
          spent: '\$320',
          budget: '\$400',
          progress: 0.8,
          icon: Icons.directions_car,
          color: AppColors.accent,
        ),
        const SizedBox(height: 8),
        CategoryProgressCard(
          category: 'Entretenimiento',
          spent: '\$280',
          budget: '\$300',
          progress: 0.93,
          icon: Icons.movie,
          color: AppColors.danger,
        ),
      ],
    );
  }



  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
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
}