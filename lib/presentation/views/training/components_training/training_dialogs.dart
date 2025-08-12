import 'package:flutter/material.dart';
import '../../../../domain/models/training_entry_model.dart';
import '../../../../domain/models/training_plan_model.dart';
import '../../../../presentation/controllers/training_controller.dart';
import '../../../theme/app_colors.dart';

class TrainingDialogs {
  static void showWorkoutDetails(BuildContext context, WorkoutPlan workout, TrainingController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surface : Colors.white,
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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimary : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: workout.exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = workout.exercises[index];
                    return Card(
                      color: isDark ? AppColors.background : Colors.grey[50],
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
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? AppColors.textPrimary : Colors.black87,
                                  ),
                                ),
                                Checkbox(
                                  value: exercise.completed,
                                  onChanged: (value) {
                                    controller.toggleExercise(workout.id, exercise.name);
                                    Navigator.pop(context);
                                    showWorkoutDetails(context, workout, controller);
                                  },
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

  static Widget _buildMetricChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static void showSleepDialog(BuildContext context, TrainingController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hoursController = TextEditingController();
    int selectedQuality = 3;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: isDark ? AppColors.surface : Colors.white,
          title: Text(
            'Registrar Sueño',
            style: TextStyle(
              color: isDark ? AppColors.textPrimary : Colors.black87,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: hoursController,
                style: TextStyle(
                  color: isDark ? AppColors.textPrimary : Colors.black87,
                ),
                decoration: InputDecoration(
                  labelText: 'Horas dormidas',
                  labelStyle: TextStyle(
                    color: isDark ? AppColors.textSecondary : Colors.black54,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Text(
                'Calidad del sueño',
                style: TextStyle(
                  color: isDark ? AppColors.textSecondary : Colors.black54,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) => IconButton(
                  onPressed: () {
                    setState(() {
                      selectedQuality = index + 1;
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: index < selectedQuality
                        ? AppColors.accent
                        : (isDark ? AppColors.textSecondary : Colors.black54),
                  ),
                )),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: AppColors.textSecondary)),
            ),
            TextButton(
              onPressed: () {
                final hours = int.tryParse(hoursController.text) ?? 8;
                controller.addSleepEntry(hours, selectedQuality);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sueño registrado correctamente')),
                );
              },
              child: const Text('Guardar', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
      ),
    );
  }

  static void showAddWorkoutDialog(BuildContext context, TrainingController controller) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _SimpleWorkoutScreen(controller: controller),
      ),
    );
  }
}

class _SimpleWorkoutScreen extends StatefulWidget {
  final TrainingController controller;

  const _SimpleWorkoutScreen({required this.controller});

  @override
  State<_SimpleWorkoutScreen> createState() => _SimpleWorkoutScreenState();
}

class _SimpleWorkoutScreenState extends State<_SimpleWorkoutScreen> {
  final _nameController = TextEditingController();
  final List<PlannedExercise> _exercises = [];
  bool _isRepeating = false;
  int _weeksToRepeat = 4;
  final List<int> _selectedDays = [];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Nuevo Entrenamiento'),
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        foregroundColor: isDark ? AppColors.textPrimary : Colors.black87,
        actions: [
          TextButton(
            onPressed: _exercises.isNotEmpty && _nameController.text.isNotEmpty ? _saveWorkout : null,
            child: const Text('Guardar', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del entrenamiento',
                    hintText: 'Ej: Pecho y Tríceps',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.fitness_center),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 16),
                _buildRepeatSection(isDark),
              ],
            ),
          ),
          Expanded(
            child: _exercises.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline, size: 64, color: AppColors.primary.withOpacity(0.5)),
                        const SizedBox(height: 16),
                        Text(
                          'Añade ejercicios a tu entrenamiento',
                          style: TextStyle(fontSize: 16, color: isDark ? AppColors.textSecondary : Colors.black54),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = _exercises[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary.withOpacity(0.2),
                            child: Text('${index + 1}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                          ),
                          title: Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                          subtitle: Text('${exercise.targetSets} series × ${exercise.targetReps} reps @ ${exercise.targetWeight}kg'),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [Icon(Icons.edit, size: 20), SizedBox(width: 8), Text('Editar')],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [Icon(Icons.delete, size: 20, color: Colors.red), SizedBox(width: 8), Text('Eliminar', style: TextStyle(color: Colors.red))],
                                ),
                              ),
                            ],
                            onSelected: (value) {
                              if (value == 'edit') {
                                _editExercise(exercise, index);
                              } else if (value == 'delete') {
                                setState(() => _exercises.removeAt(index));
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExercise,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.textPrimary),
      ),
    );
  }

  void _addExercise() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _QuickExerciseDialog(
        onSave: (exercise) => setState(() => _exercises.add(exercise)),
      ),
    );
  }

  void _editExercise(PlannedExercise exercise, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _QuickExerciseDialog(
        exercise: exercise,
        onSave: (updatedExercise) => setState(() => _exercises[index] = updatedExercise),
      ),
    );
  }

  Widget _buildRepeatSection(bool isDark) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Repetir entrenamiento', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: const Text('Programar para varios días'),
              value: _isRepeating,
              onChanged: (value) => setState(() => _isRepeating = value),
            ),
            if (_isRepeating) ...[
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Duración:', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 48,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: _weeksToRepeat > 1 ? () => setState(() => _weeksToRepeat--) : null,
                              child: const Icon(Icons.remove, size: 16),
                            ),
                            Text('$_weeksToRepeat', style: const TextStyle(fontWeight: FontWeight.bold)),
                            InkWell(
                              onTap: () => setState(() => _weeksToRepeat++),
                              child: const Icon(Icons.add, size: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('semanas'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Días de la semana:', style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Row(
                children: List.generate(7, (index) {
                  final day = index + 1;
                  final dayNames = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
                  final isSelected = _selectedDays.contains(day);
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedDays.remove(day);
                            } else {
                              _selectedDays.add(day);
                            }
                          });
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : Colors.transparent,
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.primary.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              dayNames[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? AppColors.textPrimary : AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _saveWorkout() {
    if (_nameController.text.isEmpty || _exercises.isEmpty) return;
    
    if (_isRepeating && _selectedDays.isNotEmpty) {
      final weeklyWorkouts = _selectedDays.map((day) => WeeklyWorkout(
        id: DateTime.now().millisecondsSinceEpoch.toString() + '_$day',
        name: _nameController.text,
        dayOfWeek: day,
        exercises: _exercises,
      )).toList();
      
      widget.controller.createWeeklyPlan(_nameController.text, weeklyWorkouts, _weeksToRepeat);
    } else {
      final workout = widget.controller.createCustomWorkout(_nameController.text, _exercises);
      widget.controller.addWorkout(workout);
    }
    
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Entrenamiento guardado correctamente')),
    );
  }
}

class _QuickExerciseDialog extends StatefulWidget {
  final PlannedExercise? exercise;
  final Function(PlannedExercise) onSave;

  const _QuickExerciseDialog({required this.onSave, this.exercise});

  @override
  State<_QuickExerciseDialog> createState() => _QuickExerciseDialogState();
}

class _QuickExerciseDialogState extends State<_QuickExerciseDialog> {
  late final TextEditingController _nameController;
  late int _sets;
  late int _reps;
  late double _weight;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.exercise?.name ?? '');
    _sets = widget.exercise?.targetSets ?? 3;
    _reps = widget.exercise?.targetReps ?? 10;
    _weight = widget.exercise?.targetWeight ?? 20;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surface : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.exercise == null ? 'Nuevo Ejercicio' : 'Editar Ejercicio',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimary : Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre del ejercicio',
                hintText: 'Ej: Press de banca',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.fitness_center),
              ),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildCounter('Series', _sets, (value) => setState(() => _sets = value)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildCounter('Reps', _reps, (value) => setState(() => _reps = value)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildWeightCounter(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nameController.text.isNotEmpty ? _save : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Guardar Ejercicio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: value > 1 ? () => onChanged(value - 1) : null,
                  child: const Icon(Icons.remove, size: 18),
                ),
              ),
              Expanded(
                child: Text('$value', 
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => onChanged(value + 1),
                  child: const Icon(Icons.add, size: 18),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeightCounter() {
    return Column(
      children: [
        const Text('Peso (kg)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: _weight > 0 ? () => setState(() => _weight -= 2.5) : null,
                  child: const Icon(Icons.remove, size: 18),
                ),
              ),
              Expanded(
                child: Text('${_weight.toStringAsFixed(_weight == _weight.toInt() ? 0 : 1)}', 
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _weight += 2.5),
                  child: const Icon(Icons.add, size: 18),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _save() {
    if (_nameController.text.isNotEmpty) {
      widget.onSave(PlannedExercise(
        name: _nameController.text,
        targetSets: _sets,
        targetReps: _reps,
        targetWeight: _weight,
        completed: false,
      ));
      Navigator.pop(context);
    }
  }
}