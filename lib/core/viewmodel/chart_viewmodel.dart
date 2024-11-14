import 'package:nimble_charts/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:multiplat/core/model/data_item.dart';
import 'package:multiplat/core/model/history_item.dart';
import 'package:multiplat/core/service/pane_interaction_service.dart';
import 'package:multiplat/core/viewmodel/base_viewmodel.dart';
import 'package:multiplat/locator.dart';

class ChartViewModel extends BaseViewModel {
  final PaneInteractionService _paneInteractionService =
      locator<PaneInteractionService>();

  void init() {
    _paneInteractionService.addItemChangedListener(_selectedItemChanged);
  }

  DataItem? getSelectedItem() {
    return _paneInteractionService.getSelectedItem();
  }

  @override
  void dispose() {
    _paneInteractionService.removeItemChangedListener(_selectedItemChanged);
    super.dispose();
  }

  void _selectedItemChanged() {
    setIdle();
  }

  List<charts.Series<HistoryItem, int>> getChartData() {
    final dataItem = getSelectedItem();

    if ((dataItem?.histories.length ?? 0) != 3) {
      return [];
    }

    final histories = dataItem?.histories ?? [];

    return [
      charts.Series<HistoryItem, int>(
        id: 'LastMonth',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(const Color(0xff3355aa)),
        domainFn: (HistoryItem itemHistory, _) => itemHistory.year,
        measureFn: (HistoryItem itemHistory, _) => itemHistory.historicalValue,
        data: histories[2],
      )..setAttribute(charts.rendererIdKey, 'customBar'),
      charts.Series<HistoryItem, int>(
        id: 'LastYear',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(const Color(0xff993355)),
        domainFn: (HistoryItem itemHistory, _) => itemHistory.year,
        measureFn: (HistoryItem itemHistory, _) => itemHistory.historicalValue,
        data: histories[1],
      )..setAttribute(charts.rendererIdKey, 'customBar'),
      charts.Series<HistoryItem, int>(
          id: 'Current',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(const Color(0xff558833)),
          domainFn: (HistoryItem itemHistory, _) => itemHistory.year,
          measureFn: (HistoryItem itemHistory, _) =>
              itemHistory.historicalValue,
          data: histories[0]),
    ];
  }
}
