import 'package:flutter/widgets.dart';
import 'package:multiplat/core/enum/viewstate.dart';

/// Base viewModel.

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setBusy() {
    setState(ViewState.Busy);
  }

  void setIdle() {
    setState(ViewState.Idle);
  }
}
