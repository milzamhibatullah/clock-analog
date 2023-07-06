import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clock_test/component/custom_text.dart';
import 'package:clock_test/controller/alarm_controller.dart';

/// detail alarm is redirect screen after alarm is tapped
class DetailAlarmScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailAlarmState();
  }
}

class DetailAlarmState extends State<DetailAlarmScreen> {
  /// get arguments
  var data = Get.arguments;

  ///initialize the controller
  final AlarmController _alarmController = Get.put(AlarmController());

  @override
  void initState() {
    if (data != null) {
      _alarmController.convertPayload(payload: data.toString());
    }

    super.initState();
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      barsSpace: 10,
      barRods: [
        BarChartRodData(toY: y.toDouble(), color: Colors.amber),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ct.text(text: 'Detail'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Obx(
          ///validate if alarm still setup display loading indicator
          () => _alarmController.graphIsLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _alarmController.seconds.value != 0
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AspectRatio(
                          aspectRatio: 3 / 3,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.center,
                              maxY: _alarmController.seconds.value + 10000,
                              minY: 3600,

                              ///bargroups is list of data to display on chart, example below is 1 data
                              barGroups: [
                                generateGroupData(
                                    0, _alarmController.seconds.value),
                              ],

                              ///settings title display on barchart
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: bottomTitles,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 60.0,
                                    interval: 3000,
                                    getTitlesWidget: leftTitles,
                                  ),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0.0,
                    ),
        ),
      ),
    );
  }

  ///widget for side titles on charts a.k.a Y-Axis
  Widget leftTitles(double value, TitleMeta meta) {
    String text = value.toString();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: ct.text(text: text, size: 10.0),
    );
  }

  ///widget for side titles on charts a.k.a X-Axis
  Widget bottomTitles(double value, TitleMeta meta) {
    ///parsed data payload as x-axis title
    var hours = data.toString().split(':')[0];
    var minute = data.toString().split(':')[1];

    var parsedTitle = '$hours:$minute';
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4, //margin top
      child: ct.text(
        text: parsedTitle.toString(),
      ),
    );
  }
}
