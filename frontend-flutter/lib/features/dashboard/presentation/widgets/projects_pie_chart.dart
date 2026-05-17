import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/app_colors.dart';

class ProjectsPieChart extends StatelessWidget {
  final Map<String, int> data;
  const ProjectsPieChart({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();
    final entries = data.entries.toList();
    final colors = [
      AppColors.enCours, AppColors.enAttente, AppColors.refuse,
      AppColors.valide, AppColors.culture, AppColors.sport,
    ];
    return SizedBox(
      height: 200,
      child: PieChart(PieChartData(
        sections: List.generate(entries.length, (i) => PieChartSectionData(
          value: entries[i].value.toDouble(),
          color: colors[i % colors.length],
          title: entries[i].value.toString(),
          radius: 60,
          titleStyle: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        )),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      )),
    );
  }
}