import 'package:flutter/material.dart';
import '../util/multi_select_actions.dart';
import '../util/multi_select_item.dart';
import '../util/multi_select_list_type.dart';

/// A dialog containing either a classic checkbox style list, or a chip style list.
class MultiSelectDialog<V> extends StatefulWidget with MultiSelectActions<V> {
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

  /// Sets a fixed height on the dialog.
  final double height;

  MultiSelectDialog({
    @required this.items,
    @required this.initialValue,
    this.title,
    this.onSelectionChanged,
    this.onConfirm,
    this.listType,
    this.searchable,
    this.confirmText,
    this.cancelText,
    this.selectedColor,
    this.height,
  });

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>(items);
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  List<V> _selectedValues = List<V>();
  bool _showSearch = false;
  List<MultiSelectItem<V>> _items;

  _MultiSelectDialogState(this._items);

  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _selectedValues.addAll(widget.initialValue);
    }
  }

  /// Returns a CheckboxListTile
  Widget _buildListItem(MultiSelectItem<V> item) {
    return CheckboxListTile(
      value: _selectedValues.contains(item.value),
      activeColor: widget.selectedColor,
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
    return AlertDialog(
      title: widget.searchable == false
          ? widget.title ?? Text("Select")
          : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                      : widget.title ?? Text("Select"),
                  IconButton(
                    icon: _showSearch ? Icon(Icons.close) : Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _showSearch = widget.onSearchTap(_showSearch);
                        if (!_showSearch) _items = widget.items;
                      });
                    },
                  ),
                ],
              ),
            ),
      contentPadding:
          widget.listType == null || widget.listType == MultiSelectListType.LIST
              ? EdgeInsets.only(top: 12.0)
              : EdgeInsets.all(20),
      content: Container(
        height: widget.height,
        child: SingleChildScrollView(
          child: widget.listType == null ||
                  widget.listType == MultiSelectListType.LIST
              ? ListTileTheme(
                  contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
                  child: ListBody(
                    children: _items.map(_buildListItem).toList(),
                  ),
                )
              : Wrap(
                  children: _items.map(_buildChipItem).toList(),
                ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: widget.cancelText ?? Text("CANCEL"),
          onPressed: () {
            widget.onCancelTap(context, widget.initialValue);
          },
        ),
        FlatButton(
          child: widget.confirmText ?? Text('OK'),
          onPressed: () {
            widget.onConfirmTap(context, _selectedValues, widget.onConfirm);
          },
        )
      ],
    );
  }
}
