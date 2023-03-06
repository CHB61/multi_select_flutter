
# Changelog

All notable changes to this project will be documented in this file.

## [4.1.3] - 2022-11-27
### Changed
- make initialValue non-nullable
- add didUpdateWidget that sets the selected items if initialValue changed
- add isDismissable parameter
- fixed 'items still selected after cancel'

## [4.1.2] - 2022-03-14
### Changed
- Merged [PR #87](https://github.com/CHB61/multi_select_flutter/pull/87). Thanks @benyaminbeyzaie

## [4.1.1] - 2022-03-14
### Changed
- Created a bug in 4.0.0 by removing the 'collection' dependency. It's only used to call firstWhereOrNull in _buildInheritedChipDisplay in both MultiSelectDialogField and MultiSelectBottomSheetField. This function is meant to automatically build the chips, but it may be changed or removed in the future as I don't think it is really necessary, and has caused some issues. For now, the package still depends on collection.

## [4.1.0] - 2022-03-14
### Changed
- BREAKING: re-named the 'width' and 'height' fields to dialogWidth and dialogHeight.
- Allow to adjust the width of the dialog.

### Added
- param 'separateSelectedItems' which can be used with LIST type only.

## [4.0.0] - 2021-03-20
### Changed
- Added null safety. Thanks to @ihancock for taking the initiative to apply this.

## [3.1.8] - 2021-02-15
### Fixed
- [Slow with big list](https://github.com/CHB61/multi_select_flutter/issues/18). Using a ListView.builder solves this but haven't found a way to use ListView.builder when the listType is set to MultiSelectListType.CHIP. Currently when this is set, the widget renders a Wrap inside of a SingleChildScrollView. For now, if you have a big list, do not use `MultiSelectListType.CHIP`.
## [3.1.7] - 2021-02-14
### Changed
- title param type from Text to Widget
### Fixed
- Missing generic type `<V>` on MultiSelectChipDisplay declarations
	- MultiSelectDialogField.dart line 33 in MultiSelectDialogField
	- MultiSelectDialogField.dart line 181 in _MultiSelectDialogFieldView
	- MultiSelectBottomSheetField.dart line 69 in MultiSelectBottomSheetField
	- MultiSelectBottomSheetField.dart line 209 _MultiSelectBottomSheetFieldView

This would cause a type error if you were to specify the type of a MultiSelectChipDisplay that's part of a MultiSelectDialogField or MultiSelectBottomSheetField.

```dart
MultiSelectBottomSheetField(
    onConfirm: (values) {
        _selectedAnimals = values;
    },
    items: _items,
    chipDisplay: MultiSelectChipDisplay<Animal>( // supplying the runtime type here will cause error
        onTap: (item) {
            _selectedAnimals.remove(item);
            return _selectedAnimals;
        },
    ),
)
```
The type being supplied plus returning a List<Animal> would mean that the onTap function is now `List<Animal> Function(Animal)`
However, since the declaration of the chipDisplay was missing the type (ex. MultiSelectChipDisplay chipDisplay;), it is expecting onTap to be 
`dynamic Function(dynamic)`.
## [3.1.6] - 2020-12-05
### Changed
- Autofocus search textfield when search icon is tapped.

## [3.1.5] - 2020-12-01
### Fixed
- Readme tables
## [3.1.4] - 2020-11-30
### Added
- A constructor MultiSelectChipDisplay.none() which disables the default chipDisplay that is part of MultiSelectDialogField and 
  MultiSelectBottomSheetField.
### Fixed
- When using a MultiSelectDialogField with pre-selected values, can't remove from the chipDisplay until after first confirm.
	- The onConfirm function provides a reference to the list of selected values that MultiSelectDialogField uses.
	- If you have pre-selected values set, you can now simply return the list of updated values in the onTap of the 
	  MultiSelectChipDisplay.
## [3.1.3] - 2020-10-09
### Added
- param `chipWidth` for MultiSelectChipDisplay and MultiSelectChipField. When this is set, overflowing text will show ellipses.
  

## [3.1.2] - 2020-10-09
### Added
- param `scroll`, `scrollBar`, `height` for MultiSelectChipDisplay.

## [3.1.1] - 2020-10-08
### Added
- param `showHeader` for MultiSelectChipField allowing it to be completely removed if so desired.

## [3.1.0] - 2020-10-04
### Fixed
- `type Color is not a subtype of type bool` when selecting item in MultiSelectBottomSheet
	- These errors appear in cases that use conditional expressions like this: `widget.selectedColor ?? widget.var != null ? widget.var.func() : widget.otherVar`.
- Show selected chips in MultiSelectChipDisplay when `initialValue` is set
	- Previously if you set the initialValue on a MultiSelectBottomSheetField, it would show the selected items in the bottomsheet
	  but not in the chipDisplay.

### Added
- param `checkColor` for dialog and bottomsheet widgets.

### Changed
- BREAKING: Replace `chipColor` with `unselectedColor` for dialog and bottomsheet widgets. Apply the color to unselected checkbox border or the 
  unselected chip body depending which `listType` is used.
- BREAKING: Replace deprecated `autovalidate` with `autovalidateMode` on FormField widgets

## [3.0.1] - 2020-09-28
### Fixed
- `type List<dynamic> is not a subtype of type bool` when using chipDisplay param on MultiSelectBottomSheet.

## [3.0.0] - 2020-09-27
### Added
- MultiSelectChipField
	- Similar to MultiSelectChipDisplay except that it is the primary
	  interface to select items
	- supports scroll or wrap, autoscroll, formfield features, searchable, custom items

### Changed
- MultiSelectDialogField and MultiSelectBottomSheetField now come with a default `chipDisplay`.
	- User no longer needs `chipDisplay` param to have a MultiSelectChipDisplay, a MultiSelectDialogField with only `items` specified is enough.
	- User can override or remove it. To remove it, override with MultiSelectChipDisplay(items: [])
	- User no longer needs to specify `items` on MultiSelectChipDisplay when using it as a chipDisplay param
- Combine Field/FormField widgets
	- Instead of having 2 widgets e.g. MultiSelectDialogField and MultiSelectDialogFormField,
	  move the features of MultiSelectDialogFormField into MultiSelectDialogField.
- Made MultiSelectChipDisplay stateless
- Renamed searchPlaceholder to searchHint
- Removed opacity param from MultiSelectChipDisplay.

## [2.3.0] - 2020-09-14
### Fixed
- An error was being produced when using the `icon` param in MultiSelectChipDisplay with no `colorator` applied.
- When no `title` is provided in MultiSelectDialogField, default title of Text("Select") should be provided, not a String of "Select"

### Changed
- BREAKING: Removed `chipOpacity` from MultiSelectDialog and MultiSelectBottomSheet widgets.
	- can simply set the opacity along with the color.

### Added
- Param `selectedItemsTextStyle` that applies to dialog / bottomsheet, list and chip.


## [2.2.0] - 2020-08-31
### Added
A number of parameters that allow more customizations.
- `backgroundColor`
- `chipColor`
- `chipOpacity`
- `searchIcon`, `closeSearchIcon`
- `itemsTextStyle`, `searchTextStyle`, `searchHintStyle`
- `icon` and `shape` for MultiSelectChipDisplay

## [2.1.1] - 2020-08-27
### Changed
- When colorator is applied to Field or FormField, apply the same colorator to the chipDisplay if there is one.
	Previously, when using a MultiSelectDialogField with a chipDisplay and you wanted the same effect both within
	the dialog and on the chipDisplay, you would have to define the colorator for both widgets. This is repetitive
	and not ideal. Now, the MultiSelectChipDisplay inherits the colorator from the parent field, and can still 
	override that with the use of its own colorator.

## [2.1.0] - 2020-08-24
### Added
- `colorator` param for all widgets. Set the color of individual items based on their value.
	- works like FormField's validator
	- takes a function in which you compare the value
	- return a color based on the value
	- return null if no conditions satisfied
	- applies to selected chips and checkboxes
- `opacity` param for MultiSelectChipDisplay

### Changed
- MultiSelectChipDisplay's `chipColor` param now automatically sets the opacity to 0.33 and sets the text to the same color but with full opacity.
	- previously you would have to set the chipColor to `Colors.blue.withOpacity(0.33)`
	  and textStyle to `TextStyle(Colors.blue)` to achieve this simple look.
	- you can still override this if you want different colored text by using the `textStyle` param
	- and you can override the default 0.33 opacity of the chip body with the new `opacity` param
- set the color of the FormField widgets bottom border to `selectedColor` if there is one
- set the color of confirm/cancel buttons to `selectedColor` if there is one


## [2.0.3] - 2020-08-22
### Added
- parameter `searchPlaceholder` to replace the default "Search" text.

### Fixed
- `selectedColor` wasn't being passed to MultiSelectDialog when using MultiSelectDialogField or MultiSelectDialogFormField

## [2.0.2] - 2020-08-17
### Added
- dartdoc comments

## [2.0.1] - 2020-08-17
### Added
- `selectedColor` param which controls the color of the selected checkbox / chips within a dialog / bottomsheet
- `height` param to MultiSelectDialog widgets.

### Changed
- Set the default color of the confirmText and cancelText to primary for BottomSheet widgets.

### Fixed
- onSelectionChanged wasn't being called for all widgets.

## [2.0.0] - 2020-08-16
### Added
- `MultiSelectBottomSheet`, `MultiSelectBottomSheetField`, `MultiSelectBottomSheetFormField`
- `barrierColor` param to MultiSelectDialog

### Changed
- The addition of the MultiSelectBottomSheet widgets prompted a bit of a re-write in order to de-couple widgets. Didn't want the generic MultiSelectField to be responsible for both types (dialog, bottomsheet). The new structure makes more sense and is easier to work with.
- MultiSelectField replaced with MultiSelectDialogField / MultiSelectBottomSheetField.
- MultiSelectListDialog and MultiSelectChipDialog have been replaced with MultiSelectDialog.
- dialogType replaced with listType, now accepts MultiSelectListType instead of MultiSelectDialogType.
- Improved the look of validator text, matches the look of TextFormField validator style much more closely.
- buttonText, confirmText, cancelText all now accept a Text widget instead of a string, allowing the removal of the textStyle param.

## [1.0.6] - 2020-08-14

### Fixed

- Implement scrolling in MultiSelectChipDialog.
	- When the source list was large enough, the chip dialog would just overflow but it is now scrollable.

### Changed

-  `title` is no longer required for List / Chip dialogs, default to "Select".
-  `initialSelectedItems` is now required for List / Chip dialogs.
-  `items` is now required for MultiSelectChipDisplay.
- Removed iconSize - can set icon size as param of Icon.
- Removed `state` as a parameter of MultiSelectField and created a constructor `MultiSelectField.withState()` that gets called by MultiSelectFormField.
	-  `state` never needs to be set by the user, and would do nothing if set explicitly, so it shouldn't be a named param on the default constructor.
- Updated docs

## [1.0.5] - 2020-07-10

### Fixed

- A bug was introduced in version 1.0.4 that caused the MultiSelectFormField to not highlight any of the selected values in the dialog.

### Added

- Boolean parameter 'searchable'. Useful for larger lists, the searchable parameter enables a search icon in the dialog which shows a search bar that lets you query the list.
- String parameters for 'confirmText' and 'cancelText'. This is important for users who want text other than 'OK' and 'CANCEL', especially for other languages and alphabets.

## [1.0.4] - 2020-07-06

### Changed

- Allow user to set initial selected values for MultiSelectField and MultiSelectFormField by adding param 'initialValue' to MultiSelectField, and enabled the same functionality for MultiSelectFormField by passing its existing 'initialValue' param to the MultiSelectField's new 'initialValue' param.
	- MultiSelectFormField creates a MultiSelectField which never had an 'initialValue' param that could be set by the user. Even if 'initialValue' was set on the MultiSelectFormField, it never got passed to the MultiSelectField that it creates. Now it does.
	- Previously when using a MultiSelectField or FormField, the values in the MultiSelectListDialog / MultiSelectChipDialog were only being stored internally when a user confirms the values. Now the initial values can be set before any user interaction has occurred.
	- Another use case is when a MultiSelectField is being re-inserted into the widget tree (such as one inside of a PersistentBottomSheet), and if the developer wants the previously selected values to remain after the bottomsheet re-opens, they can use this parameter to achieve that.
- Updated example app

## [1.0.3] - 2020-06-21

### Changed

- Updated pubspec.yaml project description and added homepage link

## [1.0.2] - 2020-06-20

### Added

- Example project

- analysis_options.yaml

## [1.0.1] - 2020-06-20

### Changed

- Added readme

## [1.0.0] - 2020-06-20

### Added

- Creation of MultiSelect package

- Widgets include MultiSelectListDialog, MultiSelectChipDialog, MultiSelectChipDisplay, MultiSelectField, MultiSelectFormField.