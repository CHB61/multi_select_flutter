import 'package:flutter/material.dart';
import '../util/multi_select_item.dart';

/// A widget meant to display selected values as chips.
class MultiSelectChipDisplay<V> extends StatefulWidget {
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

  /// Set the opacity of the chips.
  final double opacity;

  /// An icon to display prior to the chip's label.
  final Icon icon;

  /// Defines the border shape of a chip
  final ShapeBorder shape;

  MultiSelectChipDisplay({
    @required this.items,
    this.onTap,
    this.chipColor,
    this.alignment,
    this.decoration,
    this.textStyle,
    this.colorator,
    this.opacity,
    this.icon,
    this.shape,
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
        shape: widget.shape,
        avatar: widget.icon != null
            ? Icon(
                widget.icon.icon,
                color: widget.colorator(item.value) != null
                    ? widget.colorator(item.value).withOpacity(1)
                    : widget.icon.color ?? Theme.of(context).primaryColor,
              )
            : null,
        label: Text(
          item.label,
          style: TextStyle(
            color:
                widget.colorator != null && widget.colorator(item.value) != null
                    ? widget.textStyle != null
                        ? widget.textStyle.color ?? widget.colorator(item.value)
                        : widget.colorator(item.value)
                    : widget.textStyle != null
                        ? widget.textStyle.color ?? widget.chipColor
                        : widget.chipColor,
            fontSize:
                widget.textStyle != null ? widget.textStyle.fontSize : null,
          ),
        ),
        selected: widget.items.contains(item),
        selectedColor: widget.colorator != null &&
                widget.colorator(item.value) != null
            ? widget.colorator(item.value).withOpacity(widget.opacity ?? 0.33)
            : widget.chipColor != null
                ? widget.chipColor.withOpacity(widget.opacity ?? 0.33)
                : Theme.of(context)
                    .primaryColor
                    .withOpacity(widget.opacity ?? 0.33),
        onSelected: (_) {
          if (widget.onTap != null) widget.onTap(item.value);
        },
      ),
    );
  }
}
