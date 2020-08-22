import 'package:flutter/material.dart';
import '../util/multi_select_list_type.dart';
import '../util/multi_select_item.dart';
import '../chip_display/multi_select_chip_display.dart';
import 'multi_select_dialog_field.dart';

/// A wrapper to MultiSelectDialogField which adds FormField capability to the widget.
class MultiSelectDialogFormField<V> extends FormField<List<V>> {
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

  /// Set the color of the space outside the BottomSheet.
  final Color barrierColor;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color selectedColor;

  /// Set the placeholder text of the search field.
  final String searchPlaceholder;

  /// Give the dialog a fixed height
  final double height;
  final FormFieldValidator<List<V>> validator;
  final bool autovalidate;
  final FormFieldSetter<List<V>> onSaved;
  final GlobalKey<FormFieldState> key;

  MultiSelectDialogFormField({
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
    this.barrierColor,
    this.selectedColor,
    this.searchPlaceholder,
    this.height,
    this.key,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            initialValue: initialValue ?? List(),
            builder: (FormFieldState<List<V>> state) {
              MultiSelectDialogField field = MultiSelectDialogField(
                title: title,
                items: items,
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
                barrierColor: barrierColor,
                selectedColor: selectedColor,
                searchPlaceholder: searchPlaceholder,
                height: height,
              );
              return MultiSelectDialogField.withState(field, state);
            });
}
