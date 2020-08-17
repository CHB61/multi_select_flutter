
# Changelog

All notable changes to this project will be documented in this file.

## [2.0.2] - 2020-08-17
### Added
- dartdoc comments

## [2.0.1] - 2020-08-17
### Added
- `selectedColor` param which controls the color of the selected checkbox / chips within a dialog / bottomsheet
- `height` param to MultiSelectDialog widgets.

### Changed
- Set the default color of the confirmText and cancelText to primary

### Fixed
- onSelectionChanged wasn't being called for all widgets

## [2.0.0] - 2020-08-16
### Added
- `MultiSelectBottomSheet`, `MultiSelectBottomSheetField`, `MultiSelectBottomSheetFormField`
- `barrierColor` param to MultiSelectDialog

### Changed
- The addition of the MultiSelectBottomSheet widgets prompted a bit of a re-write in order to de-couple widgets. Didn't want the generic MultiSelectField to be responsible for both types (dialog, bottomsheet). The new architecture makes more sense and is easier to work with.
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

- Removed `state` as a parameter of MultiSelectField and created a private constructor `MultiSelectField._withState()` that gets called by MultiSelectFormField.

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

- Updated readme

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