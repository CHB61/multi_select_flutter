library flutter_multi_select;

import 'package:flutter/material.dart';

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

  void _onConfirmTap(
      BuildContext ctx, List<V> selectedValues, Function(List<V>) onConfirm) {
    Navigator.pop(ctx, selectedValues);
    if (onConfirm != null) {
      onConfirm(selectedValues);
    }
  }
}

class MultiSelectItem<V> {
  const MultiSelectItem(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectListDialog<V> extends StatefulWidget
    with MultiSelectDialogActions<V> {
  MultiSelectListDialog({
    @required this.items,
    this.initialSelectedItems,
    @required this.title,
    this.onSelectionChanged,
    this.onConfirm,
  });

  final List<MultiSelectItem<V>> items;
  final List<V> initialSelectedItems;
  final String title;
  final void Function(List<V>) onSelectionChanged;
  final void Function(List<V>) onConfirm;

  @override
  State<StatefulWidget> createState() => _MultiSelectListDialogState<V>();
}

class _MultiSelectListDialogState<V> extends State<MultiSelectListDialog<V>> {
  List<V> _selectedValues = List<V>();

  void initState() {
    super.initState();
    if (widget.initialSelectedItems != null) {
      _selectedValues.addAll(widget.initialSelectedItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: () {
            widget._onCancelTap(context, widget.initialSelectedItems);
          },
        ),
        FlatButton(
          child: Text('OK'),
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

class MultiSelectChipDialog<V> extends StatefulWidget
    with MultiSelectDialogActions<V> {
  final List<V> initialSelectedItems;
  final List<MultiSelectItem> items;
  final String title;
  final Function(List<V>) onSelectionChanged;
  final Function(List<V>) onConfirm;

  MultiSelectChipDialog({
    @required this.items,
    @required this.title,
    this.initialSelectedItems,
    this.onSelectionChanged,
    this.onConfirm,
  });
  @override
  _MultiSelectChipDialogState createState() => _MultiSelectChipDialogState<V>();
}

class _MultiSelectChipDialogState<V> extends State<MultiSelectChipDialog<V>> {
  List<V> _selectedValues = List<V>();

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
      title: Text(widget.title),
      content: Wrap(
        children: widget.items.map((item) => _buildItem(item)).toList(),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: () {
            widget._onCancelTap(context, widget.initialSelectedItems);
          },
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            widget._onConfirmTap(context, _selectedValues, widget.onConfirm);
          },
        )
      ],
    );
  }
}

enum MultiSelectDialogType { LIST, CHIP }

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
  final FormFieldState<List<V>> state;
  final double iconSize;
  final List<V> initialValue;

  MultiSelectField(
      {@required this.title,
      @required this.items,
      this.buttonText,
      this.buttonIcon,
      this.dialogType,
      this.decoration,
      this.onSelectionChanged,
      this.onConfirm,
      this.textStyle,
      this.chipDisplay,
      this.iconSize,
      this.initialValue,
      this.state});

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

class MultiSelectChipDisplay<V> extends StatefulWidget {
  final List<MultiSelectItem<V>> items;
  final Function(V) onTap;
  final Color chipColor;
  final Alignment alignment;
  final BoxDecoration decoration;
  final TextStyle textStyle;

  MultiSelectChipDisplay({
    this.items,
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
                SizedBox(height: 0),
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
  final double iconSize;
  final Key key;

  MultiSelectFormField(
      {@required this.title,
      @required this.items,
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
      this.iconSize,
      this.key})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            initialValue: initialValue ?? List(),
            builder: (FormFieldState<List<V>> state) {
              return MultiSelectField(
                state: state,
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
                iconSize: iconSize,
                initialValue: initialValue ?? List<V>(),
              );
            });
}
