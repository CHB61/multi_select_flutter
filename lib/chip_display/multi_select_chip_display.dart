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

  MultiSelectChipDisplay({
    @required this.items,
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
          style: widget.textStyle,
        ),
        selected: widget.items.contains(item),
        selectedColor: widget.chipColor,
        onSelected: (_) {
          if (widget.onTap != null) widget.onTap(item.value);
        },
      ),
    );
  }
}
