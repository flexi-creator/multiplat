import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiplat/core/util/platform_util.dart';
import 'package:multiplat/ui/view/chart_view.dart';
import 'package:multiplat/ui/view/combined_view.dart';
import 'package:multiplat/ui/view/item_detail_view.dart';
import 'package:multiplat/ui/view/items_view.dart';

const String initialRoute = "login";

class MultiPlatRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return _platformRoute(() => const ItemsView());
      case 'chart':
        return _platformRoute(() => const ChartView());
      case 'detail':
        return _platformRoute(() => const ItemDetailView());
      case 'combined':
        return _platformRoute(() => const CombinedView());
      default:
        return _platformRoute(() => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }

  static Route<dynamic> _platformRoute(Function builderCallback) {
    if (isCupertino()) {
      return CupertinoPageRoute(builder: (_) => builderCallback());
    }
    return MaterialPageRoute(builder: (_) => builderCallback());
  }
}
