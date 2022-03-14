import 'package:flutter/material.dart';
import 'multi_select_item.dart';

/// Contains common actions that are used by different multi select classes.
class MultiSelectActions<T> {
  List<T> onItemCheckedChange(
      List<T> selectedValues, T itemValue, bool checked) {
    if (checked) {
      selectedValues.add(itemValue);
    } else {
      selectedValues.remove(itemValue);
    }
    return selectedValues;
  }

  /// Pops the dialog from the navigation stack and returns the initially selected values.
  void onCancelTap(BuildContext ctx, List<T> initiallySelectedValues) {
    Navigator.pop(ctx, initiallySelectedValues);
  }

  /// Pops the dialog from the navigation stack and returns the selected values.
  /// Calls the onConfirm function if one was provided.
  void onConfirmTap(
      BuildContext ctx, List<T> selectedValues, Function(List<T>)? onConfirm) {
    Navigator.pop(ctx, selectedValues);
    if (onConfirm != null) {
      onConfirm(selectedValues);
    }
  }

  /// Accepts the search query, and the original list of items.
  /// If the search query is valid, return a filtered list, otherwise return the original list.
  List<MultiSelectItem<T>> updateSearchQuery(
      String? val, List<MultiSelectItem<T>> allItems) {
    if (val != null && val.trim().isNotEmpty) {
      List<MultiSelectItem<T>> filteredItems = [];
      for (var item in allItems) {
        if (item.label.toLowerCase().contains(val.toLowerCase())) {
          filteredItems.add(item);
        }
      }
      return filteredItems;
    } else {
      return allItems;
    }
  }

  /// Toggles the search field.
  bool onSearchTap(bool showSearch) {
    return !showSearch;
  }

  List<MultiSelectItem<T>> separateSelected(List<MultiSelectItem<T>> list) {
    List<MultiSelectItem<T>> _selectedItems = [];
    List<MultiSelectItem<T>> _nonSelectedItems = [];

    _nonSelectedItems.addAll(list.where((element) => !element.selected));
    _nonSelectedItems.sort((a, b) => a.label.compareTo(b.label));
    _selectedItems.addAll(list.where((element) => element.selected));
    _selectedItems.sort((a, b) => a.label.compareTo(b.label));

    return [..._selectedItems, ..._nonSelectedItems];
  }
}
