import 'package:flutter/material.dart';
import '../../../../widgets/settings_tile.dart';
import '../../../theme/app_colors.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<SettingsTile> tiles;
  final bool isDarkMode;

  const SettingsSection({
    super.key,
    required this.title,
    required this.tiles,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? AppColors.textPrimary : Colors.black87,
            ),
          ),
        ),
        ...tiles,
      ],
    );
  }
}