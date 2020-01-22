import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiplat/core/util/platform_util.dart';
import 'package:multiplat/core/viewmodel/chart_viewmodel.dart';
import 'package:multiplat/ui/view/base_view.dart';

class ChartView extends StatefulWidget {
  final bool combinedView;

  ChartView({this.combinedView = false});

  @override
  _ChartViewState createState() => _ChartViewState(combinedView);
}

class _ChartViewState extends State<ChartView> {
  final bool combinedView;

  _ChartViewState(this.combinedView);

  @override
  Widget build(BuildContext context) {
    return BaseView<ChartViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => _buildContent(model),
    );
  }

  Widget _buildContent(ChartViewModel model) {
    final dataItem = model.getSelectedItem();
    final title = dataItem != null ? 'Contributions for ${dataItem.title}' : '';
    if (isCupertino()) {
      return CupertinoPageScaffold(
        navigationBar: combinedView ? null : CupertinoNavigationBar(middle: Text(title)),
        child: _safeArea(title, model),
      );
    }
    return Scaffold(
      appBar: combinedView ? null : AppBar(title: Text(title)),
      body: _safeArea(title, model),
    );
  }

  SafeArea _safeArea(String title, ChartViewModel model) {
    return SafeArea(
      left: !combinedView,
      right: true,
      top: !combinedView,
      bottom: true,
      child: LayoutBuilder(
        builder: (context, constraints) => _chart(title, constraints, model),
      ),
    );
  }

  Widget _chart(String title, BoxConstraints constraints, ChartViewModel model) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Color(0xffffeeee),
      child: Column(
        children: <Widget>[
          combinedView
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title, style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.2),
                )
              : Container(),
          SizedBox(
              height: constraints.constrainHeight() - 80,
              width: constraints.constrainWidth(),
              child: CombinedDataItemsChart(model.getChartData())),
        ],
      ),
    );
  }
}

class CombinedDataItemsChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  CombinedDataItemsChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.NumericComboChart(seriesList,
        animate: animate,
        // Configure the default renderer as a line renderer. This will be used
        // for any series that does not define a rendererIdKey.
        defaultRenderer: new charts.LineRendererConfig(),
        // Custom renderer configuration for the bar series.
        customSeriesRenderers: [
          new charts.BarRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customBar')
        ]);
  }
}
