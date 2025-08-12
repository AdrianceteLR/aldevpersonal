import 'package:flutter/material.dart';
import '../../../../domain/providers/training_provider.dart';
import '../../../theme/app_colors.dart';

class WeeklyCalendarTab extends StatelessWidget {
  final TrainingState trainingState;

  const WeeklyCalendarTab({
    super.key,
    required this.trainingState,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final weekDays = _getWeekDays();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Esta Semana',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimary : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...weekDays.map((day) => _buildDayCard(day, isDark)),
        ],
      ),
    );
  }

  Widget _buildDayCard(WeekDay day, bool isDark) {
    final workouts = _getWorkoutsForDay(day.date);
    
    return Card(
      color: isDark ? AppColors.surface : Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: day.isToday ? AppColors.primary : (isDark ? AppColors.textPrimary : Colors.black87),
                      ),
                    ),
                    Text(
                      '${day.date.day}/${day.date.month}',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? AppColors.textSecondary : Colors.black54,
                      ),
                    ),
                  ],
                ),
                if (day.isToday)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'HOY',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (workouts.isEmpty)
              Text(
                'Día de descanso',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: isDark ? AppColors.textSecondary : Colors.black54,
                ),
              )
            else
              ...workouts.map((workout) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: workout.completed 
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: workout.completed ? AppColors.success : AppColors.accent,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      workout.completed ? Icons.check_circle : Icons.fitness_center,
                      color: workout.completed ? AppColors.success : AppColors.accent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workout.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDark ? AppColors.textPrimary : Colors.black87,
                            ),
                          ),
                          Text(
                            '${workout.exercises.length} ejercicios',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppColors.textSecondary : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          ],
        ),
      ),
    );
  }

  List<WeekDay> _getWeekDays() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    
    return List.generate(7, (index) {
      final date = startOfWeek.add(Duration(days: index));
      return WeekDay(
        name: _getDayName(date.weekday),
        date: date,
        isToday: date.day == now.day && date.month == now.month && date.year == now.year,
      );
    });
  }

  List<dynamic> _getWorkoutsForDay(DateTime date) {
    return trainingState.workoutPlans.where((workout) {
      return workout.scheduledDate.day == date.day &&
             workout.scheduledDate.month == date.month &&
             workout.scheduledDate.year == date.year;
    }).toList();
  }

  String _getDayName(int weekday) {
    const days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
    return days[weekday - 1];
  }
}

class WeekDay {
  final String name;
  final DateTime date;
  final bool isToday;

  WeekDay({
    required this.name,
    required this.date,
    required this.isToday,
  });
}