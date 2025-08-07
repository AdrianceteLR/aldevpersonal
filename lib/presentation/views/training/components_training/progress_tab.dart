import 'package:flutter/material.dart';
import '../../../../widgets/progress_chart.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab({super.key});

  @override
  Widget build(BuildContext context) {
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
}