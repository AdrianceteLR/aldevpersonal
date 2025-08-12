import 'package:aldevpersonal/presentation/theme/app_colors.dart';
import 'package:aldevpersonal/widgets/category_progress_card.dart';
import 'package:aldevpersonal/widgets/enhanced_bar_chart.dart';
import 'package:aldevpersonal/widgets/expense_chart.dart';
import 'package:aldevpersonal/widgets/filter_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/finances_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = ref.watch(financesControllerProvider.notifier);
    final selectedPeriod = ref.watch(financesControllerProvider);
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      body: RefreshIndicator(
        key: controller.refreshIndicatorKey,
        onRefresh: controller.handleRefresh,
        color: AppColors.primary,
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.summary.when(
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
              _buildPeriodFilter(controller, selectedPeriod),
              const SizedBox(height: 20),
              QuickActionsSection(
                isDark: isDark,
                onAddIncome: () => FinancesDialogs.showAddMovementDialog(context, ref, isIncome: true),
                onAddExpense: () => FinancesDialogs.showAddMovementDialog(context, ref, isIncome: false),
                onTransfer: () {},
                onExport: () => FinancesDialogs.showExportDialog(context),
              ),
              const SizedBox(height: 20),
              controller.monthlyData.when(
                data: (data) => EnhancedBarChart(
                  incomeData: controller.convertToBarData(data['income'] ?? []),
                  expenseData: controller.convertToBarData(data['expense'] ?? []),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => EnhancedBarChart(
                  incomeData: controller.getMockBarIncomeData(),
                  expenseData: controller.getMockBarExpenseData(),
                ),
              ),
              const SizedBox(height: 20),
              controller.categoryData.when(
                data: (data) => ExpenseChart(data: controller.convertToPieData(data)),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => ExpenseChart(data: controller.getMockChartData()),
              ),
              const SizedBox(height: 20),
              _buildCategoryProgress(isDark, controller),
              const SizedBox(height: 20),
              controller.movements.when(
                data: (movements) => RecentMovementsSection(
                  isDark: isDark,
                  movements: movements.take(5).toList(),
                  onEdit: (movement) => FinancesDialogs.showEditMovementDialog(context, ref, movement),
                  onDelete: (movementId) => controller.deleteMovement(context, movementId),
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

  Widget _buildPeriodFilter(FinancesController controller, String selectedPeriod) {
    return FilterChips(
      options: const ['Esta semana', 'Este mes', 'Este año'],
      selectedOption: selectedPeriod,
      onSelected: controller.changePeriod,
    );
  }

  Widget _buildCategoryProgress(bool isDark, FinancesController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progreso por Categoría',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? AppColors.textPrimary : Colors.black87),
        ),
        const SizedBox(height: 12),
        controller.categoryData.when(
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
                final budget = entry.value * 1.3;
                final progress = entry.value / budget;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CategoryProgressCard(
                    category: controller.getCategoryDisplayName(entry.key),
                    spent: '${entry.value.toStringAsFixed(0)}€',
                    budget: '${budget.toStringAsFixed(0)}€',
                    progress: progress.clamp(0.0, 1.0),
                    icon: controller.getCategoryIcon(entry.key),
                    color: controller.getCategoryColor(entry.key),
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
}