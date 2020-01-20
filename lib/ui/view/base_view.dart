import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiplat/core/viewmodel/base_viewmodel.dart';
import 'package:multiplat/locator.dart';

/// Base view.

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  BaseView({this.builder, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return ChangeNotifierProvider<T>.value(
          value: model,
          child: Consumer<T>(builder: widget.builder));
    } catch (e, s) {
      // provide better stack dump as web only shows single line by default
      print('Error occurred in BaseView: $e');
      print('$s');
      // rethrow; // swallow error for the time being
    }
  }
}
