import 'package:flutter/material.dart';
import '../multi_select_flutter.dart';

class MultiSelectChipField<V> extends FormField<List<V>> {
  /// Style the Container that makes up the field.
  final BoxDecoration? decoration;

  /// List of items to select from.
  final List<MultiSelectItem<V>> items;

  /// Color of the chip while not selected.
  final Color? chipColor;

  /// Sets the color of the chip while selected.
  final Color? selectedChipColor;

  /// Style the text of the chips.
  final TextStyle? textStyle;

  /// Style the text of the selected chips.
  final TextStyle? selectedTextStyle;

  /// The icon displayed in front of text on selected chips.
  final Icon? icon;

  /// Replaces the deafult search icon when searchable is true.
  final Icon? searchIcon;

  /// Replaces the default close search icon when searchable is true.
  final Icon? closeSearchIcon;

  /// Set a ShapeBorder. Typically a RoundedRectangularBorder.
  final ShapeBorder? chipShape;

  /// Defines the header text.
  final Text? title;

  /// Enables horizontal scrolling. Default is true.
  final bool scroll;

  /// A function that sets the color of selected items based on their value.
  final Color Function(V)? colorator;

  /// Fires when a chip is tapped. A good time to store the selected values.
  final Function(List<V>)? onTap;

  /// Enables search functionality.
  final bool? searchable;

  /// Set the search hint.
  final String? searchHint;

  /// Set the TextStyle of the search hint.
  final TextStyle? searchHintStyle;

  /// Set the TextStyle of the text that gets typed into the search bar.
  final TextStyle? searchTextStyle;

  /// Set the header color.
  final Color? headerColor;

  /// Build a custom widget that gets created dynamically for each item.
  final Widget Function(MultiSelectItem<V>, FormFieldState<List<V>>)?
      itemBuilder;

  /// Set the height of the selectable area.
  final double? height;

  /// Make use of the ScrollController to automatically scroll through the list.
  final Function(ScrollController)? scrollControl;

  /// Define a HorizontalScrollBar.
  final HorizontalScrollBar? scrollBar;

  /// Determines whether to show the header.
  final bool showHeader;

  /// Set the width of the chip.
  final double? chipWidth;

  final List<V> initialValue;
  final AutovalidateMode autovalidateMode;
  final FormFieldValidator<List<V>>? validator;
  final FormFieldSetter<List<V>>? onSaved;
  final GlobalKey<FormFieldState>? key;

  MultiSelectChipField({
    required this.items,
    this.decoration,
    this.chipColor,
    this.selectedChipColor,
    this.colorator,
    this.textStyle,
    this.selectedTextStyle,
    this.icon,
    this.searchIcon,
    this.closeSearchIcon,
    this.chipShape,
    this.onTap,
    this.title,
    this.scroll = true,
    this.searchable,
    this.searchHint,
    this.searchHintStyle,
    this.searchTextStyle,
    this.headerColor,
    this.key,
    this.onSaved,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.initialValue = const [],
    this.itemBuilder,
    this.height,
    this.scrollControl,
    this.scrollBar,
    this.showHeader = true,
    this.chipWidth,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            autovalidateMode: autovalidateMode,
            initialValue: initialValue,
            builder: (FormFieldState<List<V>> state) {
              _MultiSelectChipFieldView view = _MultiSelectChipFieldView<V>(
                items: items,
                decoration: decoration,
                chipColor: chipColor,
                selectedChipColor: selectedChipColor,
                colorator: colorator,
                textStyle: textStyle,
                selectedTextStyle: selectedTextStyle,
                icon: icon,
                searchIcon: searchIcon,
                closeSearchIcon: closeSearchIcon,
                chipShape: chipShape,
                onTap: onTap,
                title: title,
                scroll: scroll,
                initialValue: initialValue,
                searchable: searchable,
                searchHint: searchHint,
                searchHintStyle: searchHintStyle,
                searchTextStyle: searchTextStyle,
                headerColor: headerColor,
                itemBuilder: itemBuilder,
                height: height,
                scrollControl: scrollControl,
                scrollBar: scrollBar,
                showHeader: showHeader,
                chipWidth: chipWidth,
              );
              return _MultiSelectChipFieldView<V?>.withState(
                  view as _MultiSelectChipFieldView<V?>, state);
            });
}

// ignore: must_be_immutable
class _MultiSelectChipFieldView<V> extends StatefulWidget
    with MultiSelectActions {
  final BoxDecoration? decoration;
  final List<MultiSelectItem<V>> items;
  final List<MultiSelectItem<V>>? selectedItems;
  final Color? chipColor;
  final Color? selectedChipColor;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final Icon? icon;
  final Icon? searchIcon;
  final Icon? closeSearchIcon;
  final ShapeBorder? chipShape;
  final Text? title;
  final bool scroll;
  final bool? searchable;
  final String? searchHint;
  final TextStyle? searchHintStyle;
  final TextStyle? searchTextStyle;
  final List<V> initialValue;
  final Color? Function(V)? colorator;
  final Function(List<V>)? onTap;
  final Color? headerColor;
  final Widget Function(MultiSelectItem<V>, FormFieldState<List<V>>)?
      itemBuilder;
  final double? height;
  FormFieldState<List<V>>? state;
  final Function(ScrollController)? scrollControl;
  final HorizontalScrollBar? scrollBar;
  final bool showHeader;
  final double? chipWidth;

  _MultiSelectChipFieldView({
    required this.items,
    this.selectedItems,
    this.decoration,
    this.chipColor,
    this.selectedChipColor,
    this.colorator,
    this.textStyle,
    this.selectedTextStyle,
    this.icon,
    this.chipShape,
    this.onTap,
    this.title,
    this.scroll = true,
    this.initialValue = const [],
    this.searchable,
    this.searchHint,
    this.searchIcon,
    this.closeSearchIcon,
    this.searchHintStyle,
    this.searchTextStyle,
    this.headerColor,
    this.itemBuilder,
    this.height,
    this.scrollControl,
    this.scrollBar,
    this.showHeader = true,
    this.chipWidth,
  });

  /// This constructor allows a FormFieldState to be passed in. Called by MultiSelectChipField.
  _MultiSelectChipFieldView.withState(
      _MultiSelectChipFieldView<V> field, FormFieldState<List<V>> state)
      : items = field.items,
        title = field.title,
        decoration = field.decoration,
        initialValue = field.initialValue,
        selectedChipColor = field.selectedChipColor,
        chipShape = field.chipShape,
        colorator = field.colorator,
        chipColor = field.chipColor,
        icon = field.icon,
        closeSearchIcon = field.closeSearchIcon,
        selectedItems = field.selectedItems,
        textStyle = field.textStyle,
        scroll = field.scroll,
        selectedTextStyle = field.selectedTextStyle,
        onTap = field.onTap,
        searchable = field.searchable,
        searchHint = field.searchHint,
        searchIcon = field.searchIcon,
        searchTextStyle = field.searchTextStyle,
        searchHintStyle = field.searchHintStyle,
        headerColor = field.headerColor,
        itemBuilder = field.itemBuilder,
        height = field.height,
        scrollControl = field.scrollControl,
        scrollBar = field.scrollBar,
        showHeader = field.showHeader,
        chipWidth = field.chipWidth,
        state = state;

  @override
  __MultiSelectChipFieldViewState createState() =>
      __MultiSelectChipFieldViewState<V>(items);
}

class __MultiSelectChipFieldViewState<V>
    extends State<_MultiSelectChipFieldView<V?>> {
  List<V?> _selectedValues = [];
  bool _showSearch = false;
  List<MultiSelectItem> _items;
  ScrollController _scrollController = ScrollController();

  __MultiSelectChipFieldViewState(this._items);

  void initState() {
    super.initState();
    _selectedValues.addAll(widget.initialValue);

    if (widget.scrollControl != null && widget.scroll)
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToPosition());
  }

  @override
  void didUpdateWidget(_MultiSelectChipFieldView<V> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue != widget.initialValue) {
      _selectedValues = [];
      _selectedValues.addAll(widget.initialValue);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.state!.didChange(_selectedValues);
      });
    }
    if (oldWidget.items != widget.items) {
      _items = [...widget.items];
    }
  }

  _scrollToPosition() {
    widget.scrollControl!(_scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: widget.decoration ??
              BoxDecoration(
                border:
                    Border.all(width: 1, color: Theme.of(context).primaryColor),
              ),
          child: Column(
            children: [
              widget.showHeader
                  ? Container(
                      color:
                          widget.headerColor ?? Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _showSearch
                              ? Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: TextField(
                                      style: widget.searchTextStyle,
                                      decoration: InputDecoration(
                                        hintStyle: widget.searchHintStyle,
                                        hintText: widget.searchHint ?? "Search",
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: widget.selectedChipColor ??
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          _items = widget.updateSearchQuery(
                                              val, widget.items);
                                        });
                                      },
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: widget.title != null
                                      ? Text(
                                          widget.title!.data!,
                                          style: TextStyle(
                                              color: widget.title!.style != null
                                                  ? widget.title!.style!.color
                                                  : null,
                                              fontSize:
                                                  widget.title!.style != null
                                                      ? widget.title!.style!
                                                              .fontSize ??
                                                          18
                                                      : 18),
                                        )
                                      : Text(
                                          "Select",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                ),
                          widget.searchable != null && widget.searchable!
                              ? IconButton(
                                  icon: _showSearch
                                      ? widget.closeSearchIcon ??
                                          Icon(
                                            Icons.close,
                                            size: 22,
                                          )
                                      : widget.searchIcon ??
                                          Icon(
                                            Icons.search,
                                            size: 22,
                                          ),
                                  onPressed: () {
                                    setState(() {
                                      _showSearch = !_showSearch;
                                      if (!_showSearch) _items = widget.items;
                                    });
                                  },
                                )
                              : Padding(
                                  padding: EdgeInsets.all(18),
                                ),
                        ],
                      ),
                    )
                  : Container(),
              widget.scroll
                  ? Container(
                      padding: widget.itemBuilder == null
                          ? EdgeInsets.symmetric(horizontal: 5)
                          : null,
                      width: MediaQuery.of(context).size.width,
                      height: widget.height ??
                          MediaQuery.of(context).size.height * 0.08,
                      child: widget.scrollBar != null
                          ? Scrollbar(
                              thumbVisibility: widget.scrollBar!.isAlwaysShown,
                              controller: _scrollController,
                              child: ListView.builder(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: _items.length,
                                itemBuilder: (ctx, index) {
                                  return widget.itemBuilder != null
                                      ? widget.itemBuilder!(
                                          _items[index] as MultiSelectItem<V>,
                                          widget.state!)
                                      : _buildItem(
                                          _items[index] as MultiSelectItem<V?>);
                                },
                              ),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: _items.length,
                              itemBuilder: (ctx, index) {
                                return widget.itemBuilder != null
                                    ? widget.itemBuilder!(
                                        _items[index] as MultiSelectItem<V>,
                                        widget.state!)
                                    : _buildItem(
                                        _items[index] as MultiSelectItem<V?>);
                              },
                            ),
                    )
                  : Container(
                      height: widget.height,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(
                        children: widget.itemBuilder != null
                            ? _items
                                .map((item) => widget.itemBuilder!(
                                    item as MultiSelectItem<V>, widget.state!))
                                .toList()
                            : _items
                                .map((item) =>
                                    _buildItem(item as MultiSelectItem<V?>))
                                .toList(),
                      ),
                    ),
            ],
          ),
        ),
        widget.state != null && widget.state!.hasError
            ? Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                    child: Text(
                      widget.state!.errorText!,
                      style: TextStyle(
                        color: Colors.red[800],
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  Widget _buildItem(MultiSelectItem<V?> item) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        shape: widget.chipShape as OutlinedBorder? ??
            RoundedRectangleBorder(
              side: BorderSide(
                  color: widget.colorator != null &&
                          widget.colorator!(item.value) != null &&
                          _selectedValues.contains(item.value)
                      ? widget.colorator!(item.value)!
                      : widget.selectedChipColor ??
                          Theme.of(context).primaryColor),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15.0),
                bottom: Radius.circular(15.0),
              ),
            ),
        avatar: _selectedValues.contains(item.value)
            ? widget.icon != null
                ? Icon(
                    widget.icon!.icon,
                    color: widget.colorator != null &&
                            widget.colorator!(item.value) != null
                        ? widget.colorator!(item.value)!.withOpacity(1)
                        : widget.icon!.color ??
                            widget.selectedChipColor ??
                            Theme.of(context).primaryColor,
                  )
                : null
            : null,
        label: Container(
          width: widget.chipWidth,
          child: Text(
            item.label,
            overflow: TextOverflow.ellipsis,
            style: _selectedValues.contains(item.value)
                ? TextStyle(
                    color: widget.colorator != null &&
                            widget.colorator!(item.value) != null
                        ? widget.colorator!(item.value)!.withOpacity(1)
                        : widget.selectedTextStyle != null
                            ? widget.selectedTextStyle!.color
                            : null)
                : TextStyle(
                    color: widget.textStyle != null
                        ? widget.textStyle!.color ?? widget.chipColor
                        : widget.chipColor,
                    fontSize: widget.textStyle != null
                        ? widget.textStyle!.fontSize
                        : null,
                  ),
          ),
        ),
        selected: _selectedValues.contains(item.value),
        backgroundColor: widget.chipColor ?? Colors.white70,
        selectedColor:
            widget.colorator != null && widget.colorator!(item.value) != null
                ? widget.colorator!(item.value)
                : widget.selectedChipColor != null
                    ? widget.selectedChipColor
                    : Theme.of(context).primaryColor.withOpacity(0.33),
        onSelected: (_) {
          if (_) {
            _selectedValues.add(item.value);
            if (widget.state != null) {
              widget.state!.didChange(_selectedValues);
            }
          } else {
            _selectedValues.remove(item.value);
            if (widget.state != null) {
              widget.state!.didChange(_selectedValues);
            }
          }
          if (widget.onTap != null) widget.onTap!(_selectedValues);
        },
      ),
    );
  }
}
