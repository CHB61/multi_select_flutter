import 'package:flutter/material.dart';
import '../util/multi_select_list_type.dart';
import '../util/multi_select_item.dart';
import '../chip_display/multi_select_chip_display.dart';
import 'multi_select_bottom_sheet_field.dart';

/// A wrapper to MultiSelectBottomSheetField which adds FormField capability to the widget.
class MultiSelectBottomSheetFormField<V> extends FormField<List<V>> {
  /// An enum that determines which type of list to render.
  final MultiSelectListType listType;

  /// Style the Container that makes up the field.
  final BoxDecoration decoration;

  /// Set text that is displayed on the button.
  final Text buttonText;

  /// Specify the button icon.
  final Icon buttonIcon;

  /// The text at the top of the dialog.
  final Text title;

  /// List of items to select from.
  final List<MultiSelectItem<V>> items;

  /// Fires when the an item is selected / unselected.
  final void Function(List<V>) onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<V>) onConfirm;

  /// Attach a MultiSelectChipDisplay to this field.
  final MultiSelectChipDisplay chipDisplay;

  /// The list of selected values before interaction.
  final List<V> initialValue;

  /// Toggles search functionality.
  final bool searchable;

  /// Text on the confirm button.
  final Text confirmText;

  /// Text on the cancel button.
  final Text cancelText;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color selectedColor;

  /// Set the color of the space outside the BottomSheet.
  final Color barrierColor;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color Function(V) colorator;

  /// Set the placeholder text of the search field.
  final String searchPlaceholder;

  /// Set the initial height of the BottomSheet.
  final double initialChildSize;

  /// Set the minimum height threshold of the BottomSheet before it closes.
  final double minChildSize;

  /// Set the maximum height of the BottomSheet.
  final double maxChildSize;
  final ShapeBorder shape;
  final bool autovalidate;
  final FormFieldValidator<List<V>> validator;
  final FormFieldSetter<List<V>> onSaved;
  final GlobalKey<FormFieldState> key;

  MultiSelectBottomSheetFormField({
    @required this.items,
    this.title,
    this.buttonText,
    this.buttonIcon,
    this.listType,
    this.decoration,
    this.onSelectionChanged,
    this.onConfirm,
    this.chipDisplay,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.autovalidate = false,
    this.searchable,
    this.confirmText,
    this.cancelText,
    this.selectedColor,
    this.key,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.shape,
    this.barrierColor,
    this.searchPlaceholder,
    this.colorator,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            initialValue: initialValue ?? List(),
            builder: (FormFieldState<List<V>> state) {
              MultiSelectBottomSheetField field = MultiSelectBottomSheetField(
                items: items,
                title: title,
                buttonText: buttonText,
                buttonIcon: buttonIcon,
                chipDisplay: chipDisplay,
                decoration: decoration,
                listType: listType,
                onConfirm: onConfirm,
                onSelectionChanged: onSelectionChanged,
                initialValue: initialValue,
                searchable: searchable,
                confirmText: confirmText,
                cancelText: cancelText,
                selectedColor: selectedColor,
                initialChildSize: initialChildSize,
                minChildSize: minChildSize,
                maxChildSize: maxChildSize,
                shape: shape,
                barrierColor: barrierColor,
                searchPlaceholder: searchPlaceholder,
                colorator: colorator,
              );
              return MultiSelectBottomSheetField.withState(field, state);
            });
}
