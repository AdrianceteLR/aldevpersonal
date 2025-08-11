// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/finance/finance_movement_model.dart';
import '../../../../domain/providers/finance_provider.dart';
import '../../../theme/app_colors.dart';

class FinancesDialogs {
  static void showExportDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        title: Text(
          'Exportar Reporte',
          style: TextStyle(
            color: isDark ? AppColors.textPrimary : Colors.black87,
          ),
        ),
        content: Text(
          '¿En qué formato deseas exportar el reporte?',
          style: TextStyle(
            color: isDark ? AppColors.textSecondary : Colors.black54,
          ),
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

  static void showAddMovementDialog(BuildContext context, WidgetRef ref, {bool? isIncome}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final TextEditingController amountController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    MovementCategory? selectedCategory;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surface : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nuevo Movimiento',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimary : Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              if (isIncome == null) ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          showAddMovementDialog(context, ref, isIncome: true);
                        },
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
                        onPressed: () {
                          Navigator.pop(context);
                          showAddMovementDialog(context, ref, isIncome: false);
                        },
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
                  controller: amountController,
                  style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                  decoration: InputDecoration(
                    labelText: 'Monto',
                    labelStyle: TextStyle(color: isDark ? AppColors.textSecondary : Colors.black54),
                    suffixText: '€',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: isDark ? AppColors.textSecondary : Colors.black54),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<MovementCategory>(
                  value: selectedCategory,
                  style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                  decoration: InputDecoration(
                    labelText: 'Categoría',
                    labelStyle: TextStyle(color: isDark ? AppColors.textSecondary : Colors.black54),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: isDark ? AppColors.textSecondary : Colors.black54),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: _getCategories(isIncome).map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.displayName),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  style: TextStyle(color: isDark ? AppColors.textPrimary : Colors.black87),
                  decoration: InputDecoration(
                    labelText: 'Descripción (opcional)',
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
                    onPressed: () => _saveMovement(context, ref, isIncome, amountController, descriptionController, selectedCategory),
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

  static void showEditMovementDialog(BuildContext context, WidgetRef ref, FinanceMovement movement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Movimiento'),
        content: const Text('Funcionalidad próximamente'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  static List<MovementCategory> _getCategories(bool isIncome) {
    if (isIncome) {
      return [
        MovementCategory.salary,
        MovementCategory.freelance,
        MovementCategory.investment,
        MovementCategory.gift,
        MovementCategory.other_income,
      ];
    } else {
      return [
        MovementCategory.food,
        MovementCategory.transport,
        MovementCategory.entertainment,
        MovementCategory.health,
        MovementCategory.shopping,
        MovementCategory.bills,
        MovementCategory.rent,
        MovementCategory.other_expense,
      ];
    }
  }

  static Future<void> _saveMovement(
    BuildContext context,
    WidgetRef ref,
    bool isIncome,
    TextEditingController amountController,
    TextEditingController descriptionController,
    MovementCategory? selectedCategory,
  ) async {
    try {
      final amount = double.tryParse(amountController.text) ?? 0;
      if (amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ingresa un monto válido'),
            backgroundColor: AppColors.danger,
          ),
        );
        return;
      }

      if (selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecciona una categoría'),
            backgroundColor: AppColors.danger,
          ),
        );
        return;
      }

      await ref.read(financeActionsProvider).addMovement(
        title: selectedCategory.displayName,
        amount: amount,
        type: isIncome ? MovementType.income : MovementType.expense,
        category: selectedCategory,
        description: descriptionController.text.isEmpty ? null : descriptionController.text,
      );
      
      Navigator.pop(context);
      
      // Refrescar todos los datos
      ref.refresh(financeMovementsProvider);
      ref.refresh(financeSummaryProvider);
      ref.refresh(monthlyChartDataProvider);
      ref.refresh(categoryChartDataProvider);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Movimiento agregado correctamente'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }
}