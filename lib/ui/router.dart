import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multiplat/core/util/platform_util.dart';
import 'package:multiplat/ui/view/chart_view.dart';
import 'package:multiplat/ui/view/combined_view.dart';
import 'package:multiplat/ui/view/item_detail_view.dart';
import 'package:multiplat/ui/view/items_view.dart';

const String initialRoute = "login";

class MultiplatRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return _platformRoute(() => ItemsView());
      case 'chart':
        return _platformRoute(() => ChartView());
      case 'detail':
        return _platformRoute(() => ItemDetailView());
      case 'combined':
        return _platformRoute(() => CombinedView());
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
