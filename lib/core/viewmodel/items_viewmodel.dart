import 'package:multiplat/core/model/data_item.dart';
import 'package:multiplat/core/service/data_item_service.dart';
import 'package:multiplat/core/service/pane_interaction_service.dart';
import 'package:multiplat/core/util/multiplat_shared_prefs.dart';
import 'package:multiplat/core/viewmodel/base_viewmodel.dart';
import 'package:multiplat/locator.dart';

class ItemsViewModel extends BaseViewModel {
  ItemsViewModel({this.combinedView = false});

  final bool combinedView;
  final DataItemService _dataItemService = locator<DataItemService>();
  final PaneInteractionService _paneInteractionService = locator<PaneInteractionService>();
  final MultiplatSharedPrefs _appSharedPrefs = locator<MultiplatSharedPrefs>();

  Future<void> getData() async {
    setBusy();
    final items = await _dataItemService.getData();
    final savedIndex = await _appSharedPrefs.getSelectedItemIndex();
    _paneInteractionService.setItems(items);

    // Server json payload was created this way:
    // var js = jsonEncode({"contributors": items});
    // print('$js');

    Future.delayed(const Duration(milliseconds: 250), () {
      _paneInteractionService.setSelectedItemIndex(savedIndex);
      setIdle();
    });
  }

  int getItemCount() => _paneInteractionService.getItemCount();

  DataItem getItemAt(int index) => _paneInteractionService.getItemAt(index);

  void itemSelected(int index) {
    _paneInteractionService.setSelectedItemIndex(index);
    _appSharedPrefs.setSelectedItemIndex(index);
  }
}
