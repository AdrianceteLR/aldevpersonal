import 'package:aldevpersonal/domain/providers/dashboard_navigation_provider.dart';
import 'package:aldevpersonal/presentation/views/assistant/assistant_view.dart';
import 'package:aldevpersonal/presentation/views/finances/finances_view.dart';
import 'package:aldevpersonal/presentation/views/home_view';
import 'package:aldevpersonal/presentation/views/more_view.dart';
import 'package:aldevpersonal/presentation/views/training/training_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(dashboardNavProvider);
    final pages = [
      const HomeView(),
      const FinancesView(),
      const TrainingView(),
      const AssistantView(),
      const MoreView(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => ref.read(dashboardNavProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Finanzas'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Entreno'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'Asistente'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'Más'),
        ],
      ),
    );
  }
}
