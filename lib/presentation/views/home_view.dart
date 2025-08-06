import 'package:flutter/material.dart';
import '../../widgets/enhanced_summary_card.dart';
import '../../widgets/training_summary_card.dart';
import '../theme/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildFinanceSummary(),
            const SizedBox(height: 20),
_buildTrainingSummary(),
            const SizedBox(height: 20),
            _buildSleepSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bienvenido',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        Text(
          'Resumen de tu día',
          style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildFinanceSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Finanzas',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: EnhancedSummaryCard(
                title: 'Balance',
                amount: '\$2,450',
                percentage: '+12.5%',
                icon: Icons.account_balance_wallet,
                color: AppColors.primary,
                sparklineData: const [2100, 2200, 2300, 2250, 2400, 2450],
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: EnhancedSummaryCard(
                title: 'Ingresos',
                amount: '\$3,200',
                percentage: '+8.2%',
                icon: Icons.trending_up,
                color: AppColors.success,
                sparklineData: const [2800, 2900, 3100, 3000, 3150, 3200],
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: EnhancedSummaryCard(
                title: 'Gastos',
                amount: '\$750',
                percentage: '-5.1%',
                icon: Icons.trending_down,
                color: AppColors.danger,
                sparklineData: const [800, 780, 790, 760, 740, 750],
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrainingSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Entrenamiento',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TrainingSummaryCard(
                title: 'Entrenamientos',
                value: '4',
                subtitle: 'Esta semana',
                icon: Icons.fitness_center,
                color: AppColors.primary,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TrainingSummaryCard(
                title: 'Peso Actual',
                value: '75kg',
                subtitle: '+2kg este mes',
                icon: Icons.monitor_weight,
                color: AppColors.success,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSleepSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descanso',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TrainingSummaryCard(
                title: 'Sueño Anoche',
                value: '7.5h',
                subtitle: 'Calidad: Buena',
                icon: Icons.bedtime,
                color: AppColors.accent,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TrainingSummaryCard(
                title: 'Promedio',
                value: '7.2h',
                subtitle: 'Última semana',
                icon: Icons.schedule,
                color: AppColors.primaryDark,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
