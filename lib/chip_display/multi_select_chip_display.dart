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

  /// Set the opacity of the chips
  final double opacity;

  MultiSelectChipDisplay({
    @required this.items,
    this.onTap,
    this.chipColor,
    this.alignment,
    this.decoration,
    this.textStyle,
    this.colorator,
    this.opacity,
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
          style: widget.colorator != null &&
                  widget.colorator(item.value) != null
              ? TextStyle(
                  color:
                      widget.textStyle != null && widget.textStyle.color != null
                          ? widget.textStyle.color
                          : widget.colorator(item.value),
                  fontSize: widget.textStyle != null &&
                          widget.textStyle.fontSize != null
                      ? widget.textStyle.fontSize
                      : null)
              // there is no colorator for this chip item
              : widget.chipColor != null
                  // but there is a chipColor, so we want to set the text color to chipColor. If a textStyle.color is defined, use that first.
                  ? widget.textStyle != null
                      ? TextStyle(
                          color: widget.textStyle.color ?? widget.chipColor,
                          fontSize: widget.textStyle.fontSize)
                      : TextStyle(color: widget.chipColor)
                  // there is no chipColor, use the original textStyle
                  : widget.textStyle,
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
