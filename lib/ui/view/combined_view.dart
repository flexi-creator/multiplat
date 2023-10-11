import 'package:flutter/material.dart';
import 'package:multiplat/ui/view/chart_view.dart';
import 'package:multiplat/ui/view/item_detail_view.dart';
import 'package:multiplat/ui/view/items_view.dart';

class CombinedView extends StatelessWidget {
  static const MIN_COMBINED_WIDTH = 800;
  static const MIN_COMBINED_HEIGHT = 600;

  const CombinedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => _combinedWidgets(constraints),
    );
  }

  Widget _combinedWidgets(BoxConstraints constraints) {
    final width = constraints.constrainWidth();
    final height = constraints.constrainHeight();
    // print('combined w: $width h: $height');
    if (width > MIN_COMBINED_WIDTH && height > MIN_COMBINED_HEIGHT) {
      return SizedBox(
        width: width,
        height: height,
        child: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: ItemsView(combinedView: true),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: ItemDetailView(combinedView: true),
                    ),
                    Flexible(
                      flex: 3,
                      child: ChartView(combinedView: true),
                    ),
                  ],
                ),
              ),
            ]),
      );
    }
    return const ItemsView();
  }
}
