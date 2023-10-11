import 'package:multiplat/core/model/data_item.dart';
import 'package:multiplat/core/service/pane_interaction_service.dart';
import 'package:multiplat/core/viewmodel/base_viewmodel.dart';
import 'package:multiplat/locator.dart';

class ItemDetailViewModel extends BaseViewModel {
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
}
