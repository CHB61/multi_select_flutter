import 'package:collection/collection.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import '../util/multi_select_actions.dart';
import '../util/multi_select_item.dart';
import '../util/multi_select_list_type.dart';

class Grouping<MultiSelectItem>
    implements ExpandableListSection<MultiSelectItem> {
  //store expand state.
  late bool expanded;

  //return item model list.
  late List<MultiSelectItem> items;

  //example header, optional
  late String header;

  @override
  List<MultiSelectItem> getItems() {
    return items;
  }

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }
}

typedef HeaderBuilder = Widget Function(BuildContext context, int index);

/// A bottom sheet widget containing either a classic checkbox style list, or a chip style list.
class MultiGroupSelectBottomSheet<V> extends StatefulWidget
    with MultiSelectActions<V> {
  /// List of items to select from.
  // final List<MultiSelectItem<V>> items;

  final List<Grouping<MultiSelectItem<V>>> items;

  /// The list of selected values before interaction.
  final List<V>? initialValue;

  /// The text at the top of the BottomSheet.
  final Widget? title;

  /// Fires when the an item is selected / unselected.
  final void Function(List<V>)? onSelectionChanged;

  /// Fires when confirm is tapped.
  final void Function(List<V>)? onConfirm;

  /// Text on the confirm button.
  final Text? confirmText;

  /// Text on the cancel button.
  final Text? cancelText;

  /// An enum that determines which type of list to render.
  final MultiSelectListType? listType;

  /// Sets the color of the checkbox or chip when it's selected.
  final Color? selectedColor;

  /// Set the initial height of the BottomSheet.
  final double? initialChildSize;

  /// Set the minimum height threshold of the BottomSheet before it closes.
  final double? minChildSize;

  /// Set the maximum height of the BottomSheet.
  final double? maxChildSize;

  // List Expandable header builder
  final ExpandableHeaderBuilder? listHeaderBuilder;

  // List Expandable header builder
  final HeaderBuilder? headerBuilder;

  /// Set the placeholder text of the search field.
  final String? searchHint;

  /// A function that sets the color of selected items based on their value.
  /// It will either set the chip color, or the checkbox color depending on the list type.
  final Color? Function(V)? colorator;

  /// Color of the chip body or checkbox border while not selected.
  final Color? unselectedColor;

  /// Icon button that shows the search field.
  final Icon? searchIcon;

  /// Icon button that hides the search field
  final Icon? closeSearchIcon;

  /// Style the text on the chips or list tiles.
  final TextStyle? itemsTextStyle;

  /// Style the text on the selected chips or list tiles.
  final TextStyle? selectedItemsTextStyle;

  /// Style the cancel text.
  final TextStyle? cancelTextStyle;

  /// Style the confirm text.
  final TextStyle? confirmTextStyle;

  /// Style the search text.
  final TextStyle? searchTextStyle;

  /// Style the search hint.
  final TextStyle? searchHintStyle;

  /// Set the color of the check in the checkbox
  final Color? checkColor;

  final EdgeInsets? padding;
  final EdgeInsets? innerPadding;

  final Color? cardColor;

  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  final int? maxItemsDisplay;

  final Widget? subChild;
  final Widget? subChildOpen;
  final Widget? arrowWidget;

  final EdgeInsets? bottomPadding;

  final bool? hasBottom;

  final Widget? header;

  MultiGroupSelectBottomSheet(
      {required this.items,
      required this.initialValue,
      this.title,
      this.onSelectionChanged,
      this.onConfirm,
      this.listType,
      this.cancelText,
      this.confirmText,
      this.cancelTextStyle,
      this.confirmTextStyle,
      this.selectedColor,
      this.initialChildSize,
      this.minChildSize,
      this.maxChildSize,
      this.colorator,
      this.unselectedColor,
      this.searchIcon,
      this.closeSearchIcon,
      this.itemsTextStyle,
      this.searchTextStyle,
      this.searchHint,
      this.searchHintStyle,
      this.selectedItemsTextStyle,
      this.checkColor,
      this.listHeaderBuilder,
      this.headerBuilder,
      this.padding,
      this.innerPadding,
      this.cardColor,
      this.borderRadius,
      this.boxShadow,
      this.maxItemsDisplay,
      this.subChild,
      this.subChildOpen,
      this.arrowWidget,
      this.bottomPadding,
      this.hasBottom,
      this.header});

  @override
  _MultiGroupSelectBottomSheetState<V> createState() =>
      _MultiGroupSelectBottomSheetState<V>(items,
          listHeaderBuilder: listHeaderBuilder,
          headerBuilder: headerBuilder,
          padding: padding,
          cardColor: cardColor,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          maxItemsDisplay: maxItemsDisplay,
          innerPadding: innerPadding,
          subChild: subChild,
          subChildOpen: subChildOpen,
          arrowWidget: arrowWidget);
}

class _MultiGroupSelectBottomSheetState<V>
    extends State<MultiGroupSelectBottomSheet<V>> {
  List<V> _selectedValues = [];
  List<Grouping<MultiSelectItem<V>>> _items;

  final ExpandableHeaderBuilder? listHeaderBuilder;
  final HeaderBuilder? headerBuilder;
  final EdgeInsets? padding;
  final EdgeInsets? innerPadding;
  final Color? cardColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final int? maxItemsDisplay;

  final Widget? subChild;
  final Widget? subChildOpen;
  final Widget? arrowWidget;

  _MultiGroupSelectBottomSheetState(this._items,
      {this.listHeaderBuilder,
      this.headerBuilder,
      this.padding,
      this.innerPadding,
      this.cardColor,
      this.borderRadius,
      this.boxShadow,
      this.maxItemsDisplay,
      this.subChild,
      this.subChildOpen,
      this.arrowWidget});

  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _selectedValues.addAll(widget.initialValue!);
    }
  }

  /// Returns a CheckboxListTile
  Widget _buildListItem(MultiSelectItem<V> item) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: widget.unselectedColor ?? Colors.black54,
        accentColor: widget.selectedColor ?? Theme.of(context).primaryColor,
      ),
      child: CheckboxListTile(
        checkColor: widget.checkColor,
        value: _selectedValues.contains(item.value),
        activeColor: widget.colorator != null
            ? widget.colorator!(item.value) ?? widget.selectedColor
            : widget.selectedColor,
        title: Text(
          item.label,
          style: _selectedValues.contains(item.value)
              ? widget.selectedItemsTextStyle
              : widget.itemsTextStyle,
        ),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (checked) {
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked!);
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(_selectedValues);
          }
        },
      ),
    );
  }

  /// Returns a ChoiceChip
  Widget _buildChipItem(MultiSelectItem<V> item) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        backgroundColor: widget.unselectedColor,
        selectedColor:
            widget.colorator != null && widget.colorator!(item.value) != null
                ? widget.colorator!(item.value)
                : widget.selectedColor != null
                    ? widget.selectedColor
                    : Theme.of(context).primaryColor.withOpacity(0.35),
        label: Text(
          item.label,
          style: _selectedValues.contains(item.value)
              ? widget.selectedItemsTextStyle != null
                  ? widget.selectedItemsTextStyle!.copyWith(
                      color: widget.colorator != null &&
                              widget.colorator!(item.value) != null
                          ? widget.selectedItemsTextStyle != null
                              ? widget.selectedItemsTextStyle!.color ??
                                  widget.colorator!(item.value)!.withOpacity(1)
                              : widget.colorator!(item.value)!.withOpacity(1)
                          : widget.selectedItemsTextStyle != null
                              ? widget.selectedItemsTextStyle!.color ??
                                  (widget.selectedColor != null
                                      ? widget.selectedColor!.withOpacity(1)
                                      : Theme.of(context).primaryColor)
                              : widget.selectedColor != null
                                  ? widget.selectedColor!.withOpacity(1)
                                  : null,
                      fontSize: widget.selectedItemsTextStyle != null
                          ? widget.selectedItemsTextStyle!.fontSize
                          : null,
                    )
                  : TextStyle(
                      color: widget.colorator != null &&
                              widget.colorator!(item.value) != null
                          ? widget.selectedItemsTextStyle != null
                              ? widget.selectedItemsTextStyle!.color ??
                                  widget.colorator!(item.value)!.withOpacity(1)
                              : widget.colorator!(item.value)!.withOpacity(1)
                          : widget.selectedItemsTextStyle != null
                              ? widget.selectedItemsTextStyle!.color ??
                                  (widget.selectedColor != null
                                      ? widget.selectedColor!.withOpacity(1)
                                      : Theme.of(context).primaryColor)
                              : widget.selectedColor != null
                                  ? widget.selectedColor!.withOpacity(1)
                                  : null,
                      fontSize: widget.selectedItemsTextStyle != null
                          ? widget.selectedItemsTextStyle!.fontSize
                          : null,
                    )
              : widget.itemsTextStyle,
        ),
        selected: _selectedValues.contains(item.value),
        onSelected: (checked) {
          setState(() {
            _selectedValues = widget.onItemCheckedChange(
                _selectedValues, item.value, checked);
          });
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(_selectedValues);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: DraggableScrollableSheet(
        initialChildSize: widget.initialChildSize ?? 0.3,
        minChildSize: widget.minChildSize ?? 0.3,
        maxChildSize: widget.maxChildSize ?? 0.6,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.title ??
                        Text(
                          "Select",
                          style: TextStyle(fontSize: 18),
                        ),
                    Padding(
                      padding: EdgeInsets.all(15),
                    ),
                  ],
                ),
              ),
              widget.header ?? Container(),
              Expanded(
                child: widget.listType == null ||
                        widget.listType == MultiSelectListType.LIST
                    ? ExpandableListView(
                        padding: padding ?? EdgeInsets.all(10),
                        builder: SliverExpandableChildDelegate<
                                MultiSelectItem<V>,
                                Grouping<MultiSelectItem<V>>>(
                            sectionList: _items,
                            headerBuilder:
                                listHeaderBuilder ?? _buildListHeader,
                            itemBuilder:
                                (context, sectionIndex, itemIndex, index) {
                              MultiSelectItem<V> item =
                                  _items[sectionIndex].items[itemIndex];
                              return _buildListItem(item);
                              ;
                            }),
                      )
                    : SingleChildScrollView(
                        controller: scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          padding: padding ?? EdgeInsets.all(10),
                          child: Column(
                              children: _items
                                  .mapIndexed((int index, item) => Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            headerBuilder == null
                                                ? _buildHeader(context, index)
                                                : headerBuilder!(
                                                    context, index),
                                            item.items.length >
                                                    (maxItemsDisplay ?? 9)
                                                ? Expandable(
                                                    backgroundColor:
                                                        cardColor ??
                                                            Colors.white,
                                                    borderRadius: borderRadius ??
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5)),
                                                    boxShadow: boxShadow ?? [],
                                                    centralizeFirstChild: true,
                                                    clickable: Clickable.everywhere,
                                                    firstChild: Container(
                                                      padding: innerPadding ??
                                                          EdgeInsets.zero,
                                                      child: Wrap(
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .start,
                                                        alignment:
                                                            WrapAlignment.start,
                                                        children: item.items
                                                            .getRange(
                                                                0,
                                                                (maxItemsDisplay ??
                                                                    9))
                                                            .map(_buildChipItem)
                                                            .toList(),
                                                      ),
                                                    ),
                                                    secondChild: Container(
                                                      padding: innerPadding ??
                                                          EdgeInsets.zero,
                                                      child: Wrap(
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .start,
                                                        alignment:
                                                            WrapAlignment.start,
                                                        children: item.items
                                                            .getRange(
                                                                (maxItemsDisplay ??
                                                                    9),
                                                                item.items
                                                                    .length)
                                                            .map(_buildChipItem)
                                                            .toList(),
                                                      ),
                                                    ),
                                                    subChild: subChild ??
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 10, 0, 10),
                                                          child:
                                                              Text("Show more"),
                                                        ),
                                                    subChildOpen:
                                                        subChildOpen ??
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          10),
                                                              child: Text(
                                                                  "Show less"),
                                                            ),
                                                    showArrowWidget: true,
                                                    initiallyExpanded: false,
                                                    arrowWidget: arrowWidget ??
                                                        Icon(
                                                            Icons
                                                                .keyboard_arrow_up_rounded,
                                                            color: Colors.blue,
                                                            size: 25.0),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                      color: cardColor ??
                                                          Colors.white,
                                                      borderRadius: borderRadius ??
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                      boxShadow:
                                                          boxShadow ?? [],
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                            child: Container(
                                                                padding:
                                                                    innerPadding ??
                                                                        EdgeInsets
                                                                            .zero,
                                                                child: Wrap(
                                                                  crossAxisAlignment:
                                                                      WrapCrossAlignment
                                                                          .start,
                                                                  alignment:
                                                                      WrapAlignment
                                                                          .start,
                                                                  children: item
                                                                      .items
                                                                      .map(
                                                                          _buildChipItem)
                                                                      .toList(),
                                                                )))
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ))
                                  .toList()
                              // children: _items.map(_buildChipItem).toList(),
                              ),
                        ),
                      ),
              ),
              (widget.hasBottom ?? true)
                  ? Container(
                      padding: widget.bottomPadding ?? EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                widget.onCancelTap(
                                    context, widget.initialValue!);
                              },
                              child: widget.cancelText ??
                                  Text(
                                    "CANCEL",
                                    style: widget.cancelTextStyle ??
                                        TextStyle(
                                          color: (widget.selectedColor !=
                                                      null &&
                                                  widget.selectedColor !=
                                                      Colors.transparent)
                                              ? widget.selectedColor!
                                                  .withOpacity(1)
                                              : Theme.of(context).primaryColor,
                                        ),
                                  ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                widget.onConfirmTap(
                                    context, _selectedValues, widget.onConfirm);
                              },
                              child: widget.confirmText ??
                                  Text(
                                    "OK",
                                    style: widget.confirmTextStyle ??
                                        TextStyle(
                                          color: (widget.selectedColor !=
                                                      null &&
                                                  widget.selectedColor !=
                                                      Colors.transparent)
                                              ? widget.selectedColor!
                                                  .withOpacity(1)
                                              : Theme.of(context).primaryColor,
                                        ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 10,
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListHeader(BuildContext context, int sectionIndex, int index) {
    Grouping section = _items[sectionIndex];
    return InkWell(
        child: Container(
            color: Colors.lightBlue,
            height: 48,
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              section.header,
              style: TextStyle(color: Colors.white),
            )),
        onTap: () {
          //toggle section expand state
          setState(() {
            section.setSectionExpanded(!section.isSectionExpanded());
          });
        });
  }

  Widget _buildHeader(BuildContext context, int index) {
    Grouping item = _items[index];
    return Container(
        color: Colors.lightBlue,
        height: 48,
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          item.header,
          style: TextStyle(color: Colors.white),
        ));
  }
}
