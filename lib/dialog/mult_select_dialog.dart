import 'package:flutter/material.dart';
import '../util/multi_select_actions.dart';
import '../util/multi_select_item.dart';
import '../util/multi_select_list_type.dart';

/// A dialog containing either a classic checkbox style list, or a chip style list.
class MultiSelectDialog<V> extends StatefulWidget with MultiSelectActions<V> {
  final List<MultiSelectItem<V>> items;
  final List<V> initialValue;
  final Text title;
  final void Function(List<V>) onSelectionChanged;
  final void Function(List<V>) onConfirm;
  final bool searchable;
  final Text confirmText;
  final Text cancelText;
  final MultiSelectListType listType;

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

  Widget _buildListItem(MultiSelectItem<V> item) {
    return CheckboxListTile(
      value: _selectedValues.contains(item.value),
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) {
        setState(() {
          _selectedValues =
              widget.onItemCheckedChange(_selectedValues, item.value, checked);
        });
      },
    );
  }

  Widget _buildChipItem(MultiSelectItem<V> item) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        label: Text(item.label),
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
      content: SingleChildScrollView(
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
