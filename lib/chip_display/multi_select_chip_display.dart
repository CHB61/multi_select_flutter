import 'package:flutter/material.dart';
import '../util/multi_select_item.dart';

/// A widget meant to display selected values as chips.
class MultiSelectChipDisplay<V> extends StatelessWidget {
  /// The source list of selected items.
  final List<MultiSelectItem<V>> items;

  /// Fires when a chip is tapped.
  final Function(V) onTap;

  /// Set the chip color.
  final Color chipColor;

  /// Change the alignment of the chips.
  final Alignment alignment;

  /// Style the Container that makes up the chip display.
  final BoxDecoration decoration;

  /// Style the text on the chips.
  final TextStyle textStyle;

  /// A function that sets the color of selected items based on their value.
  final Color Function(V) colorator;

  /// An icon to display prior to the chip's label.
  final Icon icon;

  /// Set a ShapeBorder. Typically a RoundedRectangularBorder.
  final ShapeBorder shape;

  MultiSelectChipDisplay({
    this.items,
    this.onTap,
    this.chipColor,
    this.alignment,
    this.decoration,
    this.textStyle,
    this.colorator,
    this.icon,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    if (items == null) return Container();
    return Container(
      decoration: decoration,
      alignment: alignment ?? Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        children: items != null
            ? items.map((item) => _buildItem(item, context)).toList()
            : <Widget>[
                Container(),
              ],
      ),
    );
  }

  Widget _buildItem(MultiSelectItem<V> item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        shape: shape,
        avatar: icon != null
            ? Icon(
                icon.icon,
                color: colorator != null && colorator(item.value) != null
                    ? colorator(item.value).withOpacity(1)
                    : icon.color ?? Theme.of(context).primaryColor,
              )
            : null,
        label: Text(
          item.label,
          style: TextStyle(
            color: colorator != null && colorator(item.value) != null
                ? textStyle != null
                    ? textStyle.color ?? colorator(item.value)
                    : colorator(item.value)
                : textStyle != null && textStyle.color != null
                    ? textStyle.color
                    : chipColor != null
                        ? chipColor.withOpacity(1)
                        : null,
            fontSize: textStyle != null ? textStyle.fontSize : null,
          ),
        ),
        selected: items.contains(item),
        selectedColor: colorator != null && colorator(item.value) != null
            ? colorator(item.value)
            : chipColor != null
                ? chipColor
                : Theme.of(context).primaryColor.withOpacity(0.33),
        onSelected: (_) {
          if (onTap != null) onTap(item.value);
        },
      ),
    );
  }
}
