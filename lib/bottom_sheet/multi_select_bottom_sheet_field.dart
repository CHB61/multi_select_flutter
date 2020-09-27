import 'package:flutter/material.dart';
import '../util/multi_select_list_type.dart';
import '../chip_display/multi_select_chip_display.dart';
import '../util/multi_select_item.dart';
import 'multi_select_bottom_sheet.dart';

/// A customizable InkWell widget that opens the MultiSelectBottomSheet
// ignore: must_be_immutable
class MultiSelectBottomSheetField<V> extends FormField<List<V>> {
  /// Style the Container that makes up the field.
  final BoxDecoration decoration;

  /// Set text that is displayed on the button.
  final Text buttonText;

  /// Specify the button icon.
  final Icon buttonIcon;

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

  /// Set the hint text of the search field.
  final String searchHint;

  /// Set the initial height of the BottomSheet.
  final double initialChildSize;

  /// Set the minimum height threshold of the BottomSheet before it closes.
  final double minChildSize;

  /// Set the maximum height of the BottomSheet.
  final double maxChildSize;

  /// Apply a ShapeBorder to alter the edges of the BottomSheet.
  final ShapeBorder shape;

  /// Set the color of the space outside the BottomSheet.
  final Color barrierColor;

  /// Attach a MultiSelectChipDisplay to this field.
  final MultiSelectChipDisplay chipDisplay;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color Function(V) colorator;

  /// Set the background color of the bottom sheet.
  final Color backgroundColor;

  /// Color of the chip while not selected.
  final Color chipColor;

  /// Replaces the deafult search icon when searchable is true.
  final Icon searchIcon;

  /// Replaces the default close search icon when searchable is true.
  final Icon closeSearchIcon;

  /// The TextStyle of the items within the BottomSheet.
  final TextStyle itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle selectedItemsTextStyle;

  /// Style the text that is typed into the search field.
  final TextStyle searchTextStyle;

  /// Style the search hint.
  final TextStyle searchHintStyle;

  final bool autovalidate;
  final FormFieldValidator<List<V>> validator;
  final FormFieldSetter<List<V>> onSaved;
  final GlobalKey<FormFieldState> key;
  FormFieldState<List<V>> state;

  MultiSelectBottomSheetField({
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
    this.selectedColor,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.shape,
    this.barrierColor,
    this.searchHint,
    this.colorator,
    this.backgroundColor,
    this.chipColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchTextStyle,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
    this.key,
    this.onSaved,
    this.validator,
    this.autovalidate = false,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            initialValue: initialValue ?? List(),
            builder: (FormFieldState<List<V>> state) {
              _MultiSelectBottomSheetFieldView view =
                  _MultiSelectBottomSheetFieldView<V>(
                items: items,
                decoration: decoration,
                chipColor: chipColor,
                colorator: colorator,
                itemsTextStyle: itemsTextStyle,
                selectedItemsTextStyle: selectedItemsTextStyle,
                backgroundColor: backgroundColor,
                title: title,
                initialValue: initialValue,
                barrierColor: barrierColor,
                buttonIcon: buttonIcon,
                buttonText: buttonText,
                cancelText: cancelText,
                chipDisplay: chipDisplay,
                closeSearchIcon: closeSearchIcon,
                confirmText: confirmText,
                initialChildSize: initialChildSize,
                listType: listType,
                maxChildSize: maxChildSize,
                minChildSize: minChildSize,
                onConfirm: onConfirm,
                onSelectionChanged: onSelectionChanged,
                searchHintStyle: searchHintStyle,
                searchIcon: searchIcon,
                searchHint: searchHint,
                searchTextStyle: searchTextStyle,
                searchable: searchable,
                selectedColor: selectedColor,
                shape: shape,
              );
              return _MultiSelectBottomSheetFieldView<V>._withState(
                  view, state);
            });
}

// ignore: must_be_immutable
class _MultiSelectBottomSheetFieldView<V> extends StatefulWidget {
  final BoxDecoration decoration;
  final Text buttonText;
  final Icon buttonIcon;
  final List<MultiSelectItem<V>> items;
  final List<V> initialValue;
  final Text title;
  final void Function(List<V>) onSelectionChanged;
  final void Function(List<V>) onConfirm;
  final bool searchable;
  final Text confirmText;
  final Text cancelText;
  final MultiSelectListType listType;
  final Color selectedColor;
  final String searchHint;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final ShapeBorder shape;
  final Color barrierColor;
  final MultiSelectChipDisplay chipDisplay;
  final Color Function(V) colorator;
  final Color backgroundColor;
  final Color chipColor;
  final Icon searchIcon;
  final Icon closeSearchIcon;
  final TextStyle itemsTextStyle;
  final TextStyle selectedItemsTextStyle;
  final TextStyle searchTextStyle;
  final TextStyle searchHintStyle;
  FormFieldState<List<V>> state;

  _MultiSelectBottomSheetFieldView({
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
    this.selectedColor,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.shape,
    this.barrierColor,
    this.searchHint,
    this.colorator,
    this.backgroundColor,
    this.chipColor,
    this.searchIcon,
    this.closeSearchIcon,
    this.itemsTextStyle,
    this.searchTextStyle,
    this.searchHintStyle,
    this.selectedItemsTextStyle,
  });

  /// This constructor allows a FormFieldState to be passed in. Called by MultiSelectBottomSheetField.
  _MultiSelectBottomSheetFieldView._withState(
      _MultiSelectBottomSheetFieldView field, FormFieldState<List<V>> state)
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
        selectedColor = field.selectedColor,
        initialChildSize = field.initialChildSize,
        minChildSize = field.minChildSize,
        maxChildSize = field.maxChildSize,
        shape = field.shape,
        barrierColor = field.barrierColor,
        searchHint = field.searchHint,
        colorator = field.colorator,
        backgroundColor = field.backgroundColor,
        chipColor = field.chipColor,
        searchIcon = field.searchIcon,
        closeSearchIcon = field.closeSearchIcon,
        itemsTextStyle = field.itemsTextStyle,
        searchHintStyle = field.searchHintStyle,
        searchTextStyle = field.searchTextStyle,
        selectedItemsTextStyle = field.selectedItemsTextStyle,
        state = state;

  @override
  __MultiSelectBottomSheetFieldViewState createState() =>
      __MultiSelectBottomSheetFieldViewState<V>();
}

class __MultiSelectBottomSheetFieldViewState<V>
    extends State<_MultiSelectBottomSheetFieldView<V>> {
  List<V> _selectedItems = List<V>();
  MultiSelectChipDisplay _inheritedDisplay;

  Widget _buildInheritedChipDisplay() {
    if (widget.chipDisplay != null) {
      // if user has specified a chipDisplay, use its params
      _inheritedDisplay = MultiSelectChipDisplay<dynamic>(
        items: widget.chipDisplay.items != null &&
                widget.chipDisplay.items.isEmpty
            ? null
            : _selectedItems
                .map((e) =>
                    widget.items.firstWhere((element) => e == element.value))
                .toList(),
        colorator: widget.chipDisplay.colorator ?? widget.colorator,
        onTap: widget.chipDisplay.onTap,
        decoration: widget.chipDisplay.decoration,
        chipColor: widget.chipDisplay.chipColor ?? widget.selectedColor != null
            ? widget.selectedColor.withOpacity(0.35)
            : null,
        alignment: widget.chipDisplay.alignment,
        textStyle: widget.chipDisplay.textStyle,
        icon: widget.chipDisplay.icon,
        shape: widget.chipDisplay.shape,
      );
    } else {
      // user didn't specify a chipDisplay, build the default
      _inheritedDisplay = MultiSelectChipDisplay<dynamic>(
        items: _selectedItems
            .map(
                (e) => widget.items.firstWhere((element) => e == element.value))
            .toList(),
        colorator: widget.colorator,
        chipColor: widget.selectedColor != null
            ? widget.selectedColor.withOpacity(0.35)
            : null,
      );
    }
    return _inheritedDisplay;
  }

  _showBottomSheet(BuildContext ctx) async {
    await showModalBottomSheet(
        backgroundColor: widget.backgroundColor,
        barrierColor: widget.barrierColor,
        shape: widget.shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return MultiSelectBottomSheet<V>(
            selectedItemsTextStyle: widget.selectedItemsTextStyle,
            searchTextStyle: widget.searchTextStyle,
            searchHintStyle: widget.searchHintStyle,
            itemsTextStyle: widget.itemsTextStyle,
            searchIcon: widget.searchIcon,
            closeSearchIcon: widget.closeSearchIcon,
            chipColor: widget.chipColor,
            colorator: widget.colorator,
            searchHint: widget.searchHint,
            selectedColor: widget.selectedColor,
            listType: widget.listType,
            items: widget.items,
            cancelText: widget.cancelText,
            confirmText: widget.confirmText,
            initialValue: widget.initialValue ?? _selectedItems,
            onConfirm: (selected) {
              if (widget.state != null) {
                widget.state.didChange(selected);
              }
              _selectedItems = selected;
              if (widget.onConfirm != null) widget.onConfirm(selected);
            },
            onSelectionChanged: widget.onSelectionChanged,
            searchable: widget.searchable,
            title: widget.title,
            initialChildSize: widget.initialChildSize,
            minChildSize: widget.minChildSize,
            maxChildSize: widget.maxChildSize,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            _showBottomSheet(context);
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
                                  ? widget.selectedColor ??
                                      Theme.of(context).primaryColor
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
        _buildInheritedChipDisplay(),
        widget.state != null && widget.state.hasError
            ? SizedBox(height: 5)
            : Container(),
        widget.state != null && widget.state.hasError
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      widget.state.errorText,
                      style: TextStyle(
                        color: Colors.red[800],
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
