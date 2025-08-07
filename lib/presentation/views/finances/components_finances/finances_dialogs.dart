import 'package:flutter/material.dart';
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

  static void showAddMovementDialog(BuildContext context, {bool? isIncome}) {
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
}