import 'package:flutter/material.dart';
import '../util/horizontal_scrollbar.dart';
import '../util/multi_select_item.dart';

/// A widget meant to display selected values as chips.
// ignore: must_be_immutable
class MultiSelectChipDisplay<V> extends StatelessWidget {
  /// The source list of selected items.
  final List<MultiSelectItem<V>?>? items;

  /// Fires when a chip is tapped.
  final Function(V)? onTap;

  /// Set the chip color.
  final Color? chipColor;

  /// Change the alignment of the chips.
  final Alignment? alignment;

  /// Style the Container that makes up the chip display.
  final BoxDecoration? decoration;

  /// Style the text on the chips.
  final TextStyle? textStyle;

  /// A function that sets the color of selected items based on their value.
  final Color? Function(V)? colorator;

  /// An icon to display prior to the chip's label.
  final Icon? icon;

  /// Set a ShapeBorder. Typically a RoundedRectangularBorder.
  final ShapeBorder? shape;

  /// Enables horizontal scrolling.
  final bool scroll;

  /// Enables the scrollbar when scroll is `true`.
  final HorizontalScrollBar? scrollBar;

  final ScrollController _scrollController = ScrollController();

  /// Set a fixed height.
  final double? height;

  /// Set the width of the chips.
  final double? chipWidth;

  bool? disabled;

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
    this.scroll = false,
    this.scrollBar,
    this.height,
    this.chipWidth,
  }) {
    this.disabled = false;
  }

  MultiSelectChipDisplay.none({
    this.items = const [],
    this.disabled = true,
    this.onTap,
    this.chipColor,
    this.alignment,
    this.decoration,
    this.textStyle,
    this.colorator,
    this.icon,
    this.shape,
    this.scroll = false,
    this.scrollBar,
    this.height,
    this.chipWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (items == null || items!.isEmpty) return Container();
    return Container(
      decoration: decoration,
      alignment: alignment ?? Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: scroll ? 0 : 10),
      child: scroll
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: height ?? MediaQuery.of(context).size.height * 0.08,
              child: scrollBar != null
                  ? Scrollbar(
                      thumbVisibility: scrollBar!.isAlwaysShown,
                      controller: _scrollController,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: items!.length,
                        itemBuilder: (ctx, index) {
                          return _buildItem(items![index]!, context);
                        },
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: items!.length,
                      itemBuilder: (ctx, index) {
                        return _buildItem(items![index]!, context);
                      },
                    ),
            )
          : Wrap(
              children: items != null
                  ? items!.map((item) => _buildItem(item!, context)).toList()
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
        shape: shape as OutlinedBorder?,
        avatar: icon != null
            ? Icon(
                icon!.icon,
                color: colorator != null && colorator!(item.value) != null
                    ? colorator!(item.value)!.withOpacity(1)
                    : icon!.color ?? Theme.of(context).primaryColor,
              )
            : null,
        label: Container(
          width: chipWidth,
          child: Text(
            item.label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colorator != null && colorator!(item.value) != null
                  ? textStyle != null
                      ? textStyle!.color ?? colorator!(item.value)
                      : colorator!(item.value)
                  : textStyle != null && textStyle!.color != null
                      ? textStyle!.color
                      : chipColor != null
                          ? chipColor!.withOpacity(1)
                          : null,
              fontSize: textStyle != null ? textStyle!.fontSize : null,
            ),
          ),
        ),
        selected: items!.contains(item),
        selectedColor: colorator != null && colorator!(item.value) != null
            ? colorator!(item.value)
            : chipColor != null
                ? chipColor
                : Theme.of(context).primaryColor.withOpacity(0.33),
        onSelected: (_) {
          if (onTap != null) onTap!(item.value);
        },
      ),
    );
  }
}
