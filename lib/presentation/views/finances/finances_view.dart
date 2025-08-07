import 'package:aldevpersonal/presentation/theme/app_colors.dart';
import 'package:aldevpersonal/widgets/category_progress_card.dart';
import 'package:aldevpersonal/widgets/enhanced_bar_chart.dart';
import 'package:aldevpersonal/widgets/expense_chart.dart';
import 'package:aldevpersonal/widgets/filter_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
              _buildHeader(isDark),
              const SizedBox(height: 16),
              _buildPeriodFilter(),
              const SizedBox(height: 20),
              _buildQuickActions(isDark),
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
              _buildRecentMovements(isDark),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddMovementDialog(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: AppColors.textPrimary),
        label: const Text('Agregar', style: TextStyle(color: AppColors.textPrimary)),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Finanzas',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: isDark ? AppColors.textPrimary : Colors.black87),
            ),
            Text(
              'Resumen de $selectedPeriod',
              style: TextStyle(fontSize: 16, color: isDark ? AppColors.textSecondary : Colors.black54),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: isDark ? AppColors.textPrimary : Colors.black87),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined, color: isDark ? AppColors.textPrimary : Colors.black87),
            ),
          ],
        ),
      ],
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

  Widget _buildQuickActions(bool isDark) {
    return Card(
      elevation: 2,
      color: isDark ? AppColors.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Acciones Rápidas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? AppColors.textPrimary : Colors.black87),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: Icons.add_circle,
                  label: 'Ingreso',
                  color: AppColors.success,
                  onTap: () => _showAddMovementDialog(context, isIncome: true),
                  isDark: isDark,
                ),
                _buildActionButton(
                  icon: Icons.remove_circle,
                  label: 'Gasto',
                  color: AppColors.danger,
                  onTap: () => _showAddMovementDialog(context, isIncome: false),
                  isDark: isDark,
                ),
                _buildActionButton(
                  icon: Icons.swap_horiz,
                  label: 'Transferir',
                  color: AppColors.accent,
                  onTap: () {},
                  isDark: isDark,
                ),
                _buildActionButton(
                  icon: Icons.file_download,
                  label: 'Exportar',
                  color: AppColors.primary,
                  onTap: () => _showExportDialog(context),
                  isDark: isDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.textSecondary : Colors.black54,
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildRecentMovements(bool isDark) {
    return Card(
      elevation: 2,
      color: isDark ? AppColors.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Movimientos Recientes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? AppColors.textPrimary : Colors.black87),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Ver todos', style: TextStyle(color: AppColors.primary)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(3, (index) => _buildMovementItem(
              title: ['Salario', 'Supermercado', 'Gasolina'][index],
              amount: ['+\$2,500.00', '-\$120.50', '-\$45.00'][index],
              category: ['Trabajo', 'Alimentación', 'Transporte'][index],
              isIncome: [true, false, false][index],
              isDark: isDark,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildMovementItem({
    required String title,
    required String amount,
    required String category,
    required bool isIncome,
    required bool isDark,
  }) {
    return Dismissible(
      key: Key(title),
      background: Container(
        color: AppColors.danger,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: AppColors.textPrimary),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (isIncome ? AppColors.success : AppColors.danger).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                color: isIncome ? AppColors.success : AppColors.danger,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w500, color: isDark ? AppColors.textPrimary : Colors.black87),
                  ),
                  Text(
                    category,
                    style: TextStyle(fontSize: 12, color: isDark ? AppColors.textSecondary : Colors.black54),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isIncome ? AppColors.success : AppColors.danger,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  void _showExportDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        title: Text('Exportar Reporte', style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87)),
        content: Text(
          '¿En qué formato deseas exportar el reporte?',
          style: TextStyle(color: isDark ? AppColors.textSecondary : Colors.black54),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('PDF', style: TextStyle(color: AppColors.primary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Excel', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _showAddMovementDialog(BuildContext context, {bool? isIncome}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surface : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nuevo Movimiento',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? AppColors.textPrimary : Colors.black87),
              ),
              const SizedBox(height: 20),
              if (isIncome == null) ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.add_circle, color: AppColors.textPrimary),
                        label: const Text('Ingreso', style: TextStyle(color: AppColors.textPrimary)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.remove_circle, color: AppColors.textPrimary),
                        label: const Text('Gasto', style: TextStyle(color: AppColors.textPrimary)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.danger,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                TextField(
                  style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                  decoration: InputDecoration(
                    labelText: 'Monto',
                    labelStyle: TextStyle(color: isDark ? AppColors.textSecondary : Colors.black54),
                    prefixText: '\$',
                    prefixStyle: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: isDark ? AppColors.textSecondary : Colors.black54),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    labelStyle: TextStyle(color: isDark ? AppColors.textSecondary : Colors.black54),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: isDark ? AppColors.textSecondary : Colors.black54),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isIncome ? AppColors.success : AppColors.danger,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      isIncome ? 'Agregar Ingreso' : 'Agregar Gasto',
                      style: const TextStyle(color: AppColors.textPrimary),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
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