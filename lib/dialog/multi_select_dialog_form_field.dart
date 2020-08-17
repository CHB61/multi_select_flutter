import 'package:flutter/material.dart';
import '../util/multi_select_list_type.dart';
import '../util/multi_select_item.dart';
import '../chip_display/multi_select_chip_display.dart';
import 'multi_select_dialog_field.dart';

/// A wrapper to MultiSelectDialogField which adds FormField capability to the widget.
class MultiSelectDialogFormField<V> extends FormField<List<V>> {
  final MultiSelectListType listType;
  final BoxDecoration decoration;
  final Text buttonText;
  final Icon buttonIcon;
  final Text title;
  final List<MultiSelectItem<V>> items;
  final void Function(List<V>) onSelectionChanged;
  final void Function(List<V>) onConfirm;
  final MultiSelectChipDisplay chipDisplay;
  final FormFieldSetter<List<V>> onSaved;
  final FormFieldValidator<List<V>> validator;
  final List<V> initialValue;
  final bool autovalidate;
  final bool searchable;
  final Text confirmText;
  final Text cancelText;
  final Color barrierColor;
  final Color selectedColor;
  final double height;
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
                height: height,
              );
              return MultiSelectDialogField.withState(field, state);
            });
}
