import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multiplat/ui/view/chart_view.dart';
import 'package:multiplat/ui/view/combined_view.dart';
import 'package:multiplat/ui/view/item_detail_view.dart';
import 'package:multiplat/ui/view/items_view.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => ItemsView());
      case 'chart':
        return MaterialPageRoute(builder: (_) => ChartView());
      case 'detail':
        return MaterialPageRoute(builder: (_) => ItemDetailView());
      case 'combined':
        return MaterialPageRoute(builder: (_) => CombinedView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
