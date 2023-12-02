import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../models/weight_record.dart';
import 'dart:math';

class WeightChart extends StatelessWidget {
  final List<WeightRecord> weightRecords;
   WeightChart({super.key, required List<WeightRecord> weightRecords})
      : weightRecords = List.from(weightRecords)..sort((a, b) => a.timestamp.compareTo(b.timestamp));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: weightRecords
                  .map((record) => FlSpot(
                        record.timestamp.millisecondsSinceEpoch.toDouble(),
                        record.weight,
                      ))
                  .toList(),
              isCurved: true,
              color: Theme.of(context).primaryColor,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          minX: weightRecords.first.timestamp.millisecondsSinceEpoch.toDouble() ,
          maxX: weightRecords.last.timestamp.millisecondsSinceEpoch.toDouble() ,
          minY: 0,
          maxY: weightRecords.map((e) => e.weight).reduce(max) * 1.1, // 10% more than max weight
        ),
      ),
    );
  }
}
