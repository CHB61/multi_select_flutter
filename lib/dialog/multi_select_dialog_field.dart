import 'package:flutter/material.dart';
import '../util/multi_select_list_type.dart';
import '../util/multi_select_item.dart';
import '../chip_display/multi_select_chip_display.dart';
import 'mult_select_dialog.dart';

/// A customizable InkWell widget that opens the MultiSelectDialog
// ignore: must_be_immutable
class MultiSelectDialogField<V> extends StatefulWidget {
  final MultiSelectListType listType;
  final BoxDecoration decoration;
  final Text buttonText;
  final Icon buttonIcon;
  final Text title;
  final List<MultiSelectItem<V>> items;
  final void Function(List<V>) onSelectionChanged;
  final void Function(List<V>) onConfirm;
  final MultiSelectChipDisplay chipDisplay;
  final List<V> initialValue;
  final bool searchable;
  final Text confirmText;
  final Text cancelText;
  final Color barrierColor;
  final Color selectedColor;
  final double height;

  FormFieldState<List<V>> state;

  MultiSelectDialogField({
    @required this.items,
    this.title,
    this.buttonText,
    this.buttonIcon,
    this.listType,
    this.decoration,
    this.onSelectionChanged,
    this.onConfirm,
    this.chipDisplay,
    this.initialValue,
    this.searchable,
    this.confirmText,
    this.cancelText,
    this.barrierColor,
    this.selectedColor,
    this.height,
  });

  /// This constructor allows a FormFieldState to be passed in. Called by MultiSelectDialogFormField.
  MultiSelectDialogField.withState(
      MultiSelectDialogField field, FormFieldState<List<V>> state)
      : items = field.items,
        title = field.title,
        buttonText = field.buttonText,
        buttonIcon = field.buttonIcon,
        listType = field.listType,
        decoration = field.decoration,
        onSelectionChanged = field.onSelectionChanged,
        onConfirm = field.onConfirm,
        chipDisplay = field.chipDisplay,
        initialValue = field.initialValue,
        searchable = field.searchable,
        confirmText = field.confirmText,
        cancelText = field.cancelText,
        barrierColor = field.barrierColor,
        selectedColor = field.selectedColor,
        height = field.height,
        state = state;

  @override
  _MultiSelectDialogFieldState createState() =>
      _MultiSelectDialogFieldState<V>();
}

class _MultiSelectDialogFieldState<V> extends State<MultiSelectDialogField<V>> {
  List<V> _selectedItems = List<V>();

  /// Calls showDialog() and renders a MultiSelectDialog.
  _showDialog(BuildContext ctx) async {
    await showDialog(
      barrierColor: widget.barrierColor,
      context: context,
      builder: (ctx) {
        return MultiSelectDialog<V>(
          onSelectionChanged: widget.onSelectionChanged,
          height: widget.height,
          listType: widget.listType,
          items: widget.items,
          title: widget.title != null ? widget.title : "Select",
          initialValue: widget.initialValue ?? _selectedItems,
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
                              ? Colors.red.shade800.withOpacity(0.6)
                              : _selectedItems.isNotEmpty
                                  ? Theme.of(context).primaryColor
                                  : Colors.black45,
                          width: _selectedItems.isNotEmpty
                              ? (widget.state != null && widget.state.hasError)
                                  ? 1.4
                                  : 1.8
                              : 1.2,
                        ),
                      ),
                    )
                : widget.decoration,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.buttonText ?? Text("Select"),
                widget.buttonIcon ?? Icon(Icons.arrow_downward),
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
                  Text(
                    widget.state.errorText,
                    style: TextStyle(
                      color: Colors.red[800],
                      fontSize: 12.5,
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
