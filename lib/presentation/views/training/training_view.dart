import 'package:aldevpersonal/domain/models/training_entry_model.dart';
import 'package:aldevpersonal/presentation/theme/app_colors.dart';
import 'package:aldevpersonal/widgets/progress_chart.dart';
import 'package:aldevpersonal/widgets/training_summary_card.dart';
import 'package:aldevpersonal/widgets/workout_plan_card.dart';
import 'package:flutter/material.dart';

class TrainingView extends StatefulWidget {
  const TrainingView({super.key});

  @override
  State<TrainingView> createState() => _TrainingViewState();
}

class _TrainingViewState extends State<TrainingView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTodayTab(),
                _buildProgressTab(),
                _buildHistoryTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddWorkoutDialog(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: AppColors.textPrimary),
        label: const Text('Nuevo', style: TextStyle(color: AppColors.textPrimary)),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Entrenamiento',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              Text(
                'Tu rutina de hoy',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
            ],
          ),
          IconButton(
            onPressed: () => _showSleepDialog(context),
            icon: const Icon(Icons.bedtime, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: AppColors.textSecondary,
        tabs: const [
          Tab(text: 'Hoy'),
          Tab(text: 'Progreso'),
          Tab(text: 'Historial'),
        ],
      ),
    );
  }

  Widget _buildTodayTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TrainingSummaryCard(
                  title: 'Completados',
                  value: '2/4',
                  subtitle: 'Ejercicios hoy',
                  icon: Icons.check_circle,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TrainingSummaryCard(
                  title: 'Tiempo',
                  value: '45min',
                  subtitle: 'Entrenando',
                  icon: Icons.timer,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Plan de Hoy',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          ...List.generate(2, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: WorkoutPlanCard(
              workout: _getMockWorkouts()[index],
              onTap: () => _showWorkoutDetails(context, _getMockWorkouts()[index]),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ProgressChart(
            data: _getMockWeightProgress(),
            title: 'Progreso de Peso Corporal',
            unit: 'kg',
          ),
          const SizedBox(height: 16),
          ProgressChart(
            data: _getMockBenchProgress(),
            title: 'Press de Banca',
            unit: 'kg',
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...List.generate(5, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              color: AppColors.surface,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.check, color: AppColors.success, size: 20),
                ),
                title: Text(
                  'Entrenamiento ${index + 1}',
                  style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  '${DateTime.now().subtract(Duration(days: index)).day}/${DateTime.now().month} - 45min',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
              ),
            ),
          )),
        ],
      ),
    );
  }

  void _showWorkoutDetails(BuildContext context, WorkoutPlan workout) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workout.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: workout.exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = workout.exercises[index];
                    return Card(
                      color: AppColors.background,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  exercise.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                                ),
                                Checkbox(
                                  value: exercise.completed,
                                  onChanged: (value) {},
                                  activeColor: AppColors.success,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _buildMetricChip('${exercise.targetSets} series'),
                                const SizedBox(width: 8),
                                _buildMetricChip('${exercise.targetReps} reps'),
                                const SizedBox(width: 8),
                                _buildMetricChip('${exercise.targetWeight}kg'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500),
      ),
    );
  }

  void _showSleepDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Registrar Sueño', style: TextStyle(color: AppColors.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                labelText: 'Horas dormidas',
                labelStyle: const TextStyle(color: AppColors.textSecondary),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const Text('Calidad del sueño', style: TextStyle(color: AppColors.textSecondary)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) => IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.star,
                  color: index < 3 ? AppColors.accent : AppColors.textSecondary,
                ),
              )),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Guardar', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _showAddWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Nuevo Entrenamiento', style: TextStyle(color: AppColors.textPrimary)),
        content: const Text(
          '¿Qué tipo de entrenamiento quieres crear?',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Personalizado', style: TextStyle(color: AppColors.primary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Plantilla', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  List<WorkoutPlan> _getMockWorkouts() {
    return [
      WorkoutPlan(
        id: '1',
        name: 'Pecho y Tríceps',
        exercises: [
          const PlannedExercise(
            name: 'Press de Banca',
            targetSets: 4,
            targetReps: 8,
            targetWeight: 80,
            completed: true,
          ),
          const PlannedExercise(
            name: 'Press Inclinado',
            targetSets: 3,
            targetReps: 10,
            targetWeight: 60,
            completed: true,
          ),
          const PlannedExercise(
            name: 'Fondos',
            targetSets: 3,
            targetReps: 12,
            targetWeight: 0,
            completed: false,
          ),
        ],
        scheduledDate: DateTime.now(),
        completed: false,
      ),
      WorkoutPlan(
        id: '2',
        name: 'Espalda y Bíceps',
        exercises: [
          const PlannedExercise(
            name: 'Dominadas',
            targetSets: 4,
            targetReps: 6,
            targetWeight: 0,
            completed: false,
          ),
          const PlannedExercise(
            name: 'Remo con Barra',
            targetSets: 4,
            targetReps: 8,
            targetWeight: 70,
            completed: false,
          ),
        ],
        scheduledDate: DateTime.now().add(const Duration(days: 1)),
        completed: false,
      ),
    ];
  }

  List<ProgressData> _getMockWeightProgress() {
    return [
      ProgressData(date: '1/11', value: 73),
      ProgressData(date: '8/11', value: 73.5),
      ProgressData(date: '15/11', value: 74),
      ProgressData(date: '22/11', value: 74.8),
      ProgressData(date: '29/11', value: 75),
    ];
  }

  List<ProgressData> _getMockBenchProgress() {
    return [
      ProgressData(date: '1/11', value: 70),
      ProgressData(date: '8/11', value: 72.5),
      ProgressData(date: '15/11', value: 75),
      ProgressData(date: '22/11', value: 77.5),
      ProgressData(date: '29/11', value: 80),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}