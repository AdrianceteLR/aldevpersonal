import 'package:flutter/material.dart';
import '../presentation/theme/app_colors.dart';

class FilterChips extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onSelected;

  const FilterChips({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
  });

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.options.length,
        itemBuilder: (context, index) {
          final option = widget.options[index];
          final isSelected = option == widget.selectedOption;
          
          return Padding(
            padding: EdgeInsets.only(right: index < widget.options.length - 1 ? 8 : 0),
            child: FilterChip(
              label: Text(
                option,
                style: TextStyle(
                  color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              onSelected: (_) => widget.onSelected(option),
              backgroundColor: AppColors.surface,
              selectedColor: AppColors.primary,
              checkmarkColor: AppColors.textPrimary,
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.textSecondary.withOpacity(0.3),
              ),
            ),
          );
        },
      ),
    );
  }
}