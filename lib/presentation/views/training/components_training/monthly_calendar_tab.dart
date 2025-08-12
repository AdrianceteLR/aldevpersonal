import 'package:flutter/material.dart';
import '../../../../domain/providers/training_provider.dart';
import '../../../../domain/models/training_entry_model.dart';
import '../../../theme/app_colors.dart';

class MonthlyCalendarTab extends StatefulWidget {
  final TrainingState trainingState;
  final Function(BuildContext, WorkoutPlan) onWorkoutTap;

  const MonthlyCalendarTab({
    super.key,
    required this.trainingState,
    required this.onWorkoutTap,
  });

  @override
  State<MonthlyCalendarTab> createState() => _MonthlyCalendarTabState();
}

class _MonthlyCalendarTabState extends State<MonthlyCalendarTab> {
  DateTime _currentMonth = DateTime.now();
  DateTime? _selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final isScrolled = _scrollController.offset > 100;
      if (isScrolled != _isScrolled) {
        setState(() => _isScrolled = isScrolled);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dy > 5 && !_isScrolled) {
                    _scrollController.animateTo(
                      200,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  height: _isScrolled ? 200 : null,
                  child: _isScrolled
                      ? Column(
                          children: [
                            _buildHeader(isDark),
                            _buildWeekDaysHeader(isDark),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: _buildCalendar(isDark),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildHeader(isDark),
                            _buildWeekDaysHeader(isDark),
                            _buildCalendar(isDark),
                          ],
                        ),
                ),
              ),
              _buildSelectedDayWorkouts(isDark),
            ],
          ),
        ),
        if (_isScrolled)
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton.small(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.keyboard_arrow_up, color: AppColors.textPrimary),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => setState(() => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1)),
            icon: Icon(Icons.chevron_left, color: isDark ? AppColors.textPrimary : Colors.black87),
          ),
          Text(
            '${_getMonthName(_currentMonth.month)} ${_currentMonth.year}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimary : Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1)),
            icon: Icon(Icons.chevron_right, color: isDark ? AppColors.textPrimary : Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDaysHeader(bool isDark) {
    const days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: days.map((day) => Expanded(
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textSecondary : Colors.black54,
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildCalendar(bool isDark) {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final startDate = firstDay.subtract(Duration(days: firstDay.weekday - 1));
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        final date = startDate.add(Duration(days: index));
        final workouts = _getWorkoutsForDay(date);
        final isCurrentMonth = date.month == _currentMonth.month;
        final isToday = _isToday(date);
        final isSelected = _selectedDate != null && _isSameDay(date, _selectedDate!);
        
        return GestureDetector(
          onTap: () => setState(() => _selectedDate = date),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.3)
                  : isToday 
                      ? AppColors.primary.withOpacity(0.2)
                      : (workouts.isNotEmpty ? AppColors.accent.withOpacity(0.1) : null),
              borderRadius: BorderRadius.circular(8),
              border: isSelected 
                  ? Border.all(color: AppColors.primary, width: 2)
                  : isToday ? Border.all(color: AppColors.primary, width: 1) : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: !isCurrentMonth 
                        ? (isDark ? AppColors.textSecondary.withOpacity(0.5) : Colors.black26)
                        : isToday 
                            ? AppColors.primary
                            : (isDark ? AppColors.textPrimary : Colors.black87),
                  ),
                ),
                if (workouts.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...workouts.take(3).map((workout) => Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: workout.completed ? AppColors.success : AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                        )),
                        if (workouts.length > 3)
                          Text(
                            '+${workouts.length - 3}',
                            style: TextStyle(
                              fontSize: 8,
                              color: isDark ? AppColors.textSecondary : Colors.black54,
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectedDayWorkouts(bool isDark) {
    if (_selectedDate == null) return const SizedBox.shrink();
    
    final workouts = _getWorkoutsForDay(_selectedDate!);
    
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy < -10) {
          // Deslizar hacia arriba - expandir
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        } else if (details.delta.dy > 10) {
          // Deslizar hacia abajo - mantener pequeño
          _scrollController.animateTo(
            150,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 200),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surface : Colors.white,
          border: Border(top: BorderSide(color: isDark ? AppColors.textSecondary.withOpacity(0.2) : Colors.black12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.textSecondary : Colors.black26,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${_selectedDate!.day} de ${_getMonthName(_selectedDate!.month)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimary : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            workouts.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        'No hay entrenamientos programados',
                        style: TextStyle(
                          color: isDark ? AppColors.textSecondary : Colors.black54,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: workouts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final workout = workouts[index];
                      return Card(
                        color: isDark ? AppColors.background : Colors.grey[50],
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Icon(
                            workout.completed ? Icons.check_circle : Icons.fitness_center,
                            color: workout.completed ? AppColors.success : AppColors.accent,
                          ),
                          title: Text(
                            workout.name,
                            style: TextStyle(
                              color: isDark ? AppColors.textPrimary : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            '${workout.exercises.length} ejercicios',
                            style: TextStyle(
                              color: isDark ? AppColors.textSecondary : Colors.black54,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => widget.onWorkoutTap(context, workout),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  List<WorkoutPlan> _getWorkoutsForDay(DateTime date) {
    return widget.trainingState.workoutPlans.where((workout) {
      return workout.scheduledDate.day == date.day &&
             workout.scheduledDate.month == date.month &&
             workout.scheduledDate.year == date.year;
    }).toList();
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.day == now.day && date.month == now.month && date.year == now.year;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;
  }

  String _getMonthName(int month) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return months[month - 1];
  }
}