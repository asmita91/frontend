import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PeriodGraphPage extends StatelessWidget {
  const PeriodGraphPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Period Graph'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 1, // Define interval as needed
              verticalInterval: 1, // Define interval as needed
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: _leftTitles,
                  reservedSize: 40,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: _bottomTitles,
                  reservedSize: 30,
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            minX: 0,
            maxX: 12, // Assuming a 12 month period for demonstration
            minY: 0,
            maxY: 3, // Just an arbitrary max value for demonstration
            lineBarsData: [
              LineChartBarData(
                spots: _createSpots(),
                isCurved: true,
                color: Colors.pinkAccent,
                barWidth: 5,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Period';
        break;
      case 2:
        text = 'Fertile';
        break;
      default:
        text = '';
    }
    return Text(text, style: style, textAlign: TextAlign.right);
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    String text;
    switch (value.toInt()) {
      case 2:
        text = 'Feb';
        break;
      case 5:
        text = 'May';
        break;
      case 8:
        text = 'Aug';
        break;
      default:
        text = '';
    }
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(text, style: style));
  }

  // Generate some fake data for the chart
  List<FlSpot> _createSpots() {
    // This is just an example. You would replace this with your actual period data
    return [
      const FlSpot(1, 1), // Jan, Period
      const FlSpot(2, 2), // Feb, Fertile
      const FlSpot(3, 1), // Mar, Period
      // Continue with more data points...
    ];
  }
}
