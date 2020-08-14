library flutter_multi_select;

import 'package:flutter/material.dart';

/// Contains common actions that are used by MultiSelectListDialog and MultiSelectChipDialog.
class MultiSelectDialogActions<V> {
  List<V> _onItemCheckedChange(
      List<V> selectedValues, V itemValue, bool checked) {
    if (checked) {
      selectedValues.add(itemValue);
    } else {
      selectedValues.remove(itemValue);
    }
    return selectedValues;
  }

  void _onCancelTap(BuildContext ctx, List<V> initiallySelectedValues) {
    Navigator.pop(ctx, initiallySelectedValues);
  }

  /// Pops the AlertDialog from the navigation stack and returns the selected values.
  /// Calls the onConfirm function if one was provided.
  void _onConfirmTap(
      BuildContext ctx, List<V> selectedValues, Function(List<V>) onConfirm) {
    Navigator.pop(ctx, selectedValues);
    if (onConfirm != null) {
      onConfirm(selectedValues);
    }
  }

  /// Accepts the search query, and the original list of items.
  /// If the search query is valid, return a filtered list, otherwise return the original list.
  List<MultiSelectItem<V>> _updateSearchQuery(
      String val, List<MultiSelectItem<V>> allItems) {
    if (val != null && val.trim().isNotEmpty) {
      List<MultiSelectItem<V>> filteredItems = [];
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

  bool _onSearchTap(bool showSearch) {
    return !showSearch;
  }
}

/// The object containing value and label fields used to present data within the multi select widgets.
class MultiSelectItem<V> {
  const MultiSelectItem(this.value, this.label);

  final V value;
  final String label;
}

/// An AlertDialog containing a classic checkbox style list
class MultiSelectListDialog<V> extends StatefulWidget
    with MultiSelectDialogActions<V> {
  final List<MultiSelectItem<V>> items;
  final List<V> initialSelectedItems;
  final String title;
  final void Function(List<V>) onSelectionChanged;
  final void Function(List<V>) onConfirm;
  final bool searchable;
  final String confirmText;
  final String cancelText;

  MultiSelectListDialog({
    @required this.items,
    @required this.initialSelectedItems,
    this.title,
    this.onSelectionChanged,
    this.onConfirm,
    this.searchable,
    this.confirmText,
    this.cancelText,
  });

  @override
  State<StatefulWidget> createState() => _MultiSelectListDialogState<V>(items);
}

class _MultiSelectListDialogState<V> extends State<MultiSelectListDialog<V>> {
  List<V> _selectedValues = List<V>();
  bool _showSearch = false;
  List<MultiSelectItem<V>> _items;

  _MultiSelectListDialogState(this._items);

  void initState() {
    super.initState();
    if (widget.initialSelectedItems != null) {
      _selectedValues.addAll(widget.initialSelectedItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.searchable == false
          ? Text(widget.title != null ? widget.title : "Select")
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
                                  _items = widget._updateSearchQuery(
                                      val, widget.items);
                                });
                              },
                            ),
                          ),
                        )
                      : Text(widget.title != null ? widget.title : "Select"),
                  IconButton(
                    icon: _showSearch ? Icon(Icons.close) : Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _showSearch = widget._onSearchTap(_showSearch);
                        if (!_showSearch) _items = widget.items;
                      });
                    },
                  ),
                ],
              ),
            ),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: _items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: widget.cancelText != null
              ? Text(widget.cancelText)
              : Text('CANCEL'),
          onPressed: () {
            widget._onCancelTap(context, widget.initialSelectedItems);
          },
        ),
        FlatButton(
          child: widget.confirmText != null
              ? Text(widget.confirmText)
              : Text('OK'),
          onPressed: () {
            widget._onConfirmTap(context, _selectedValues, widget.onConfirm);
          },
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectItem<V> item) {
    return CheckboxListTile(
      value: _selectedValues.contains(item.value),
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) {
        setState(() {
          _selectedValues =
              widget._onItemCheckedChange(_selectedValues, item.value, checked);
        });
      },
    );
  }
}

/// An AlertDialog containing a chip style list
class MultiSelectChipDialog<V> extends StatefulWidget
    with MultiSelectDialogActions<V> {
  final List<V> initialSelectedItems;
  final List<MultiSelectItem> items;
  final String title;
  final Function(List<V>) onSelectionChanged;
  final Function(List<V>) onConfirm;
  final bool searchable;
  final String confirmText;
  final String cancelText;

  MultiSelectChipDialog({
    @required this.items,
    @required this.initialSelectedItems,
    this.title,
    this.onSelectionChanged,
    this.onConfirm,
    this.searchable,
    this.confirmText,
    this.cancelText,
  });
  @override
  _MultiSelectChipDialogState createState() =>
      _MultiSelectChipDialogState<V>(items);
}

class _MultiSelectChipDialogState<V> extends State<MultiSelectChipDialog<V>> {
  List<V> _selectedValues = List<V>();
  bool _showSearch = false;
  List<MultiSelectItem<V>> _items;

  _MultiSelectChipDialogState(this._items);

  void initState() {
    super.initState();
    if (widget.initialSelectedItems != null) {
      _selectedValues.addAll(widget.initialSelectedItems);
    }
  }

  Widget _buildItem(MultiSelectItem<V> item) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        label: Text(item.label),
        selected: _selectedValues.contains(item.value),
        onSelected: (checked) {
          setState(() {
            _selectedValues = widget._onItemCheckedChange(
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
      title: !widget.searchable
          ? Text(widget.title != null ? widget.title : "Select")
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
                                  _items = widget._updateSearchQuery(
                                      val, widget.items);
                                });
                              },
                            ),
                          ),
                        )
                      : Text(widget.title != null ? widget.title : "Select"),
                  IconButton(
                    icon: _showSearch ? Icon(Icons.close) : Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _showSearch = widget._onSearchTap(_showSearch);
                        if (!_showSearch) _items = widget.items;
                      });
                    },
                  ),
                ],
              ),
            ),
      content: SingleChildScrollView(
        child: Wrap(
          children: _items.map((item) => _buildItem(item)).toList(),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: widget.cancelText != null
              ? Text(widget.cancelText)
              : Text('CANCEL'),
          onPressed: () {
            widget._onCancelTap(context, widget.initialSelectedItems);
          },
        ),
        FlatButton(
          child: widget.confirmText != null
              ? Text(widget.confirmText)
              : Text('OK'),
          onPressed: () {
            widget._onConfirmTap(context, _selectedValues, widget.onConfirm);
          },
        )
      ],
    );
  }
}

enum MultiSelectDialogType { LIST, CHIP }

/// A customizable InkWell widget that opens the dialog
// ignore: must_be_immutable
class MultiSelectField<V> extends StatefulWidget {
  final MultiSelectDialogType dialogType;
  final BoxDecoration decoration;
  final String buttonText;
  final Icon buttonIcon;
  final String title;
  final List<MultiSelectItem<V>> items;
  final void Function(List<V>) onSelectionChanged;
  final void Function(List<V>) onConfirm;
  final TextStyle textStyle;
  final MultiSelectChipDisplay chipDisplay;
  final List<V> initialValue;
  final bool searchable;
  final String confirmText;
  final String cancelText;
  FormFieldState<List<V>> state;

  MultiSelectField({
    @required this.items,
    this.title,
    this.buttonText,
    this.buttonIcon,
    this.dialogType,
    this.decoration,
    this.onSelectionChanged,
    this.onConfirm,
    this.textStyle,
    this.chipDisplay,
    this.initialValue,
    this.searchable,
    this.confirmText,
    this.cancelText,
  });

  /// This constructor exists because state only needs to be passed to MultiSelectField when it's being created by MultiSelectFormField.
  /// Without this constructor, state would need to be a named optional parameter within the main contructor,
  /// resulting in a useless, confusing parameter that the user has no need for.
  MultiSelectField._withState(
      MultiSelectField field, FormFieldState<List<V>> state)
      : items = field.items,
        title = field.title,
        buttonText = field.buttonText,
        buttonIcon = field.buttonIcon,
        dialogType = field.dialogType,
        decoration = field.decoration,
        onSelectionChanged = field.onSelectionChanged,
        onConfirm = field.onConfirm,
        textStyle = field.textStyle,
        chipDisplay = field.chipDisplay,
        initialValue = field.initialValue,
        searchable = field.searchable,
        confirmText = field.confirmText,
        cancelText = field.cancelText,
        state = state;

  @override
  _MultiSelectFieldState createState() => _MultiSelectFieldState<V>();
}

class _MultiSelectFieldState<V> extends State<MultiSelectField<V>> {
  List<V> _selectedItems = List<V>();

  _showDialog(BuildContext ctx) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        if (widget.dialogType == MultiSelectDialogType.CHIP) {
          return MultiSelectChipDialog<V>(
            items: widget.items,
            title: widget.title != null ? widget.title : "Select",
            initialSelectedItems: widget.initialValue ?? _selectedItems,
            searchable: widget.searchable ?? false,
            confirmText: widget.confirmText,
            cancelText: widget.cancelText,
            onConfirm: (selected) {
              if (widget.state != null) {
                widget.state.didChange(selected);
              }
              _selectedItems = selected;
              widget.onConfirm(selected);
            },
          );
        } else {
          return MultiSelectListDialog<V>(
            items: widget.items,
            title: widget.title != null ? widget.title : "Select",
            initialSelectedItems: widget.initialValue ?? _selectedItems,
            searchable: widget.searchable ?? false,
            confirmText: widget.confirmText,
            cancelText: widget.cancelText,
            onConfirm: (selected) {
              if (widget.state != null) {
                widget.state.didChange(selected);
              }
              _selectedItems = selected;
              widget.onConfirm(selected);
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            _showDialog(context);
          },
          child: Container(
            decoration: widget.state != null
                ? widget.decoration ??
                    BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: widget.state != null && widget.state.hasError
                              ? Colors.red
                              : Colors.black,
                          width: 1,
                        ),
                      ),
                    )
                : widget.decoration,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.buttonText == null
                    ? Text(
                        "Select",
                        style: widget.textStyle,
                      )
                    : Text(
                        widget.buttonText != null ? widget.buttonText : "",
                        style:
                            widget.textStyle != null ? widget.textStyle : null,
                      ),
                widget.buttonIcon ??
                    Icon(
                      Icons.arrow_downward,
                      color: widget.textStyle != null &&
                              widget.textStyle.color != null
                          ? widget.textStyle.color
                          : null,
                    ),
              ],
            ),
          ),
        ),
        widget.chipDisplay != null &&
                (widget.chipDisplay.items != null &&
                    widget.chipDisplay.items.length > 0)
            ? widget.chipDisplay
            : Container(),
        widget.state != null && widget.state.hasError
            ? SizedBox(height: 5)
            : Container(),
        widget.state != null && widget.state.hasError
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.state.errorText,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}

/// A widget meant to display selected values as chips.
class MultiSelectChipDisplay<V> extends StatefulWidget {
  final List<MultiSelectItem<V>> items;
  final Function(V) onTap;
  final Color chipColor;
  final Alignment alignment;
  final BoxDecoration decoration;
  final TextStyle textStyle;

  MultiSelectChipDisplay({
    @required this.items,
    this.onTap,
    this.chipColor,
    this.alignment,
    this.decoration,
    this.textStyle,
  });

  @override
  _MultiSelectChipDisplayState createState() =>
      _MultiSelectChipDisplayState<V>();
}

class _MultiSelectChipDisplayState<V> extends State<MultiSelectChipDisplay<V>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      alignment: widget.alignment ?? Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        children: widget.items != null
            ? widget.items.map((item) => _buildItem(item)).toList()
            : <Widget>[
                Container(),
              ],
      ),
    );
  }

  Widget _buildItem(MultiSelectItem<V> item) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        label: Text(
          item.label,
          style: widget.textStyle != null ? widget.textStyle : null,
        ),
        selected: widget.items.contains(item),
        selectedColor: widget.chipColor != null ? widget.chipColor : null,
        onSelected: (_) {
          if (widget.onTap != null) widget.onTap(item.value);
        },
      ),
    );
  }
}

/// A wrapper to MultiSelectField which adds FormField capability to the widget.
class MultiSelectFormField<V> extends FormField<List<V>> {
  final MultiSelectDialogType dialogType;
  final BoxDecoration decoration;
  final String buttonText;
  final Icon buttonIcon;
  final String title;
  final List<MultiSelectItem<V>> items;
  final void Function(List<V>) onSelectionChanged;
  final void Function(List<V>) onConfirm;
  final TextStyle textStyle;
  final MultiSelectChipDisplay chipDisplay;
  final FormFieldSetter<List<V>> onSaved;
  final FormFieldValidator<List<V>> validator;
  final List<V> initialValue;
  final bool autovalidate;
  final bool searchable;
  final String confirmText;
  final String cancelText;
  final GlobalKey<FormFieldState> key;

  MultiSelectFormField({
    @required this.items,
    this.title,
    this.buttonText,
    this.buttonIcon,
    this.dialogType,
    this.decoration,
    this.onSelectionChanged,
    this.onConfirm,
    this.textStyle,
    this.chipDisplay,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.autovalidate = false,
    this.searchable,
    this.confirmText,
    this.cancelText,
    this.key,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            initialValue: initialValue ?? List(),
            builder: (FormFieldState<List<V>> state) {
              MultiSelectField field = MultiSelectField(
                title: title,
                items: items,
                buttonText: buttonText,
                buttonIcon: buttonIcon,
                chipDisplay: chipDisplay,
                decoration: decoration,
                dialogType: dialogType,
                onConfirm: onConfirm,
                onSelectionChanged: onSelectionChanged,
                textStyle: textStyle,
                initialValue: initialValue,
                searchable: searchable,
                confirmText: confirmText,
                cancelText: cancelText,
              );
              return MultiSelectField._withState(field, state);
            });
}
