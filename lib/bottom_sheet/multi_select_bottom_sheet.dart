import 'package:flutter/material.dart';
import '../util/multi_select_item.dart';
import '../util/multi_select_actions.dart';
import '../util/multi_select_list_type.dart';

/// A bottom sheet widget containing either a classic checkbox style list, or a chip style list.
class MultiSelectBottomSheet<V> extends StatefulWidget
    with MultiSelectActions<V> {
  /// List of items to select from.
  final List<MultiSelectItem<V>> items;

  /// The list of selected values before interaction.
  final List<V> initialValue;

  /// The text at the top of the dialog.
  final Text title;

  /// Fires when the an item is selected / unselected.
  final void Function(List<V>) onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<V>) onConfirm;

  /// Toggles search functionality.
  final bool searchable;

  /// Text on the confirm button.
  final Text confirmText;

  /// Text on the cancel button.
  final Text cancelText;

  /// An enum that determines which type of list to render.
  final MultiSelectListType listType;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color selectedColor;

  /// Set the initial height of the BottomSheet.
  final double initialChildSize;

  /// Set the minimum height threshold of the BottomSheet before it closes.
  final double minChildSize;

  /// Set the maximum height of the BottomSheet.
  final double maxChildSize;

  MultiSelectBottomSheet({
    @required this.items,
    @required this.initialValue,
    this.title,
    this.onSelectionChanged,
    this.onConfirm,
    this.listType,
    this.cancelText,
    this.confirmText,
    this.searchable,
    this.selectedColor,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
  });

  @override
  _MultiSelectBottomSheetState<V> createState() =>
      _MultiSelectBottomSheetState<V>(items);
}

class _MultiSelectBottomSheetState<V> extends State<MultiSelectBottomSheet<V>> {
  List<V> _selectedValues = List<V>();
  bool _showSearch = false;
  List<MultiSelectItem<V>> _items;

  _MultiSelectBottomSheetState(this._items);

  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _selectedValues.addAll(widget.initialValue);
    }
  }

  /// Returns a CheckboxListTile
  Widget _buildListItem(MultiSelectItem<V> item) {
    return CheckboxListTile(
      activeColor: widget.selectedColor,
      value: _selectedValues.contains(item.value),
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) {
        setState(() {
          _selectedValues =
              widget.onItemCheckedChange(_selectedValues, item.value, checked);
        });
        if (widget.onSelectionChanged != null) {
          widget.onSelectionChanged(_selectedValues);
        }
      },
    );
  }

  /// Returns a ChoiceChip
  Widget _buildChipItem(MultiSelectItem<V> item) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        selectedColor: widget.selectedColor != null
            ? widget.selectedColor.withOpacity(.2)
            : null,
        label: Text(
          item.label,
          style: _selectedValues.contains(item.value)
              ? TextStyle(color: widget.selectedColor)
              : null,
        ),
        selected: _selectedValues.contains(item.value),
        onSelected: (checked) {
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked);
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged(_selectedValues);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: DraggableScrollableSheet(
        initialChildSize: widget.initialChildSize ?? 0.3,
        minChildSize: widget.minChildSize ?? 0.3,
        maxChildSize: widget.maxChildSize ?? 0.6,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _showSearch
                        ? Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: widget.selectedColor ??
                                            Theme.of(context).primaryColor),
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _items = widget.updateSearchQuery(
                                        val, widget.items);
                                  });
                                },
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: widget.title != null
                                ? Text(
                                    widget.title.data,
                                    style: widget.title.style ??
                                        TextStyle(fontSize: 18),
                                  )
                                : Text(
                                    "Select",
                                    style: TextStyle(fontSize: 18),
                                  ),
                          ),
                    widget.searchable != null && widget.searchable
                        ? IconButton(
                            icon: _showSearch
                                ? Icon(Icons.close)
                                : Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                _showSearch = widget.onSearchTap(_showSearch);
                                if (!_showSearch) _items = widget.items;
                              });
                            },
                          )
                        : Padding(
                            padding: EdgeInsets.all(15),
                          ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: widget.listType == null ||
                          widget.listType == MultiSelectListType.LIST
                      ? ListTileTheme(
                          contentPadding:
                              EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
                          child: ListBody(
                            children: _items.map(_buildListItem).toList(),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(10),
                          child: Wrap(
                            children: _items.map(_buildChipItem).toList(),
                          ),
                        ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          widget.onCancelTap(context, widget.initialValue);
                        },
                        child: widget.cancelText ??
                            Text(
                              "CANCEL",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: FlatButton(
                        onPressed: () {
                          widget.onConfirmTap(
                              context, _selectedValues, widget.onConfirm);
                        },
                        child: widget.confirmText ??
                            Text(
                              "OK",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
