import 'dart:async';
import 'dart:math';

import 'package:brick_core/core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../brick/repository.dart';
import '../../logs/models/log.model.dart';

class HomeController extends GetxController {
  // Logs
  late final StreamSubscription<List<Log>> logsStreamSubscription;
  final logs = <Log>[].obs;
  final _logsQuery = Query(orderBy: [OrderBy.desc('date')]);
  var isLoading = true.obs;
  var errorMsg = ''.obs;

  // Charts
  late final chartsTitlesData = FlTitlesData(
    bottomTitles: _dateAxisTitles,
    topTitles: _dateAxisTitles,
  );
  late final _dateAxisTitles = AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      maxIncluded: false,
      minIncluded: false,
      getTitlesWidget: (double value, TitleMeta meta) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt());
        final datePattern = meta.axisSide == AxisSide.top ? '\'\'yy' : 'MMM';
        final dateFormat = DateFormat(datePattern);
        return Text(dateFormat.format(dateTime));
      },
    ),
  );
  final chartsMaxX =
      DateTime.now().add(Duration(days: 365)).millisecondsSinceEpoch.toDouble();

  // Weight
  final weightChartSpots = <FlSpot>[].obs;
  var minWeight = 0.0.obs;
  var maxWeight = 0.0.obs;

  @override
  void onInit() async {
    try {
      _updateLogs(await Repository().get<Log>(query: _logsQuery));
      _listenFutureLogUpdates();
    } catch (error) {
      _showErrorMsg(error);
    } finally {
      super.onInit();
    }
  }

  @override
  void onClose() {
    logsStreamSubscription.cancel();
    super.onClose();
  }

  void deleteLog(Log log) {
    Repository().delete(log);
  }

  void _updateLogs(List<Log> data) {
    isLoading.value = true;
    logs.value = data;
    _updateWeightChart();
    isLoading.value = false;
  }

  void _listenFutureLogUpdates() {
    logsStreamSubscription = Repository()
        .subscribe<Log>(query: _logsQuery)
        .listen(_updateLogs, onError: _showErrorMsg, cancelOnError: true);
  }

  void _showErrorMsg(Object error) {
    errorMsg.value = error.toString();
    isLoading.value = false;
  }

  void _updateWeightChart() {
    weightChartSpots.clear();
    minWeight.value = 0;
    maxWeight.value = 0;
    for (var log in logs.reversed) {
      if (log.weight == null) continue;
      final x = log.date.millisecondsSinceEpoch.toDouble();
      final y = log.weight!;
      weightChartSpots.add(FlSpot(x, y));
      if (y < minWeight.value || minWeight.value == 0) {
        minWeight.value = y;
      }
      if (y > maxWeight.value || maxWeight.value == 0) {
        maxWeight.value = y;
      }
    }
  }
}
