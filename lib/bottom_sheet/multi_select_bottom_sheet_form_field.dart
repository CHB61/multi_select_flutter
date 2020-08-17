import 'package:flutter/material.dart';
import '../util/multi_select_list_type.dart';
import '../util/multi_select_item.dart';
import '../chip_display/multi_select_chip_display.dart';
import 'multi_select_bottom_sheet_field.dart';

/// A wrapper to MultiSelectBottomSheetField which adds FormField capability to the widget.
class MultiSelectBottomSheetFormField<V> extends FormField<List<V>> {
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
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final ShapeBorder shape;
  final Color barrierColor;
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
    this.key,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.shape,
    this.barrierColor,
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
                initialChildSize: initialChildSize,
                minChildSize: minChildSize,
                maxChildSize: maxChildSize,
                shape: shape,
                barrierColor: barrierColor,
              );
              return MultiSelectBottomSheetField.withState(field, state);
            });
}
