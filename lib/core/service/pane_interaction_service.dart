import 'package:flutter/cupertino.dart';
import 'package:multiplat/core/model/data_item.dart';

class PaneInteractionService {
  final List<DataItem> _items = [];

  final _selectedItemNotifier = ValueNotifier(0);

  void setItems(List<DataItem> items) {
    _items.clear();
    _items.addAll(items);
  }

  int getItemCount() => _items.length;

  DataItem getItemAt(int index) => _items[index];

  void setSelectedItemIndex(int index) {
    _selectedItemNotifier.value = index;
  }

  DataItem? getSelectedItem() {
    final index = _selectedItemNotifier.value;
    if (index < _items.length) {
      return _items[index];
    }
    return null;
  }

  void addItemChangedListener(VoidCallback listener) {
    _selectedItemNotifier.addListener(listener);
  }

  void removeItemChangedListener(VoidCallback listener) {
    _selectedItemNotifier.removeListener(listener);
  }
}
