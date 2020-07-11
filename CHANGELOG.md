# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- Multi select bottom sheet widget.

## [1.0.5] - 2020-07-10
### Fixed
- A bug was introduced in version 1.0.4 that caused the MultiSelectFormField to not highlight any
    of the selected values in the dialog.

### Added
- Boolean parameter 'searchable'. Useful for larger lists, the searchable parameter enables a search
    icon in the dialog which shows a search bar that lets you query the list.

### Added
- String parameters for 'confirmText' and 'cancelText'. This is important for users who want text other than
    'OK' and 'CANCEL', especially for other languages and alphabets.

## [1.0.4] - 2020-07-06
### Changed
- Allow user to set initial selected values for MultiSelectField and MultiSelectFormField by
    adding param 'initialValue' to MultiSelectField, and enabled the same functionality for 
    MultiSelectFormField by passing its existing 'initialValue' param to the
    MultiSelectField's new 'initialValue' param.
    - MultiSelectFormField creates a MultiSelectField which never had an 'initialValue' param
        that could be set by the user. Even if 'initialValue' was set on the MultiSelectFormField, 
        it never got passed to the MultiSelectField that it creates. Now it does.
    - Previously when using a MultiSelectField or FormField, the values in the 
        MultiSelectListDialog / MultiSelectChipDialog were only being stored 
        internally when a user confirms the values. Now the initial values can be set before any 
        user interaction has occurred.
    - Another use case is when a MultiSelectField is being re-inserted into 
        the widget tree (such as one inside of a PersistentBottomSheet), and if the developer
        wants the previously selected values to remain after the bottomsheet re-opens, they can use this parameter
        to achieve that.
- Updated example app
- Updated readme
- Added unreleased section to changelog

## [1.0.3] - 2020-06-21
### Changed
- Updated pubspec.yaml project description and added homepage link

## [1.0.2] - 2020-06-20
### Added
- Example project
- analysis_options.yaml

## [1.0.1] - 2020-06-20
### Changed
- Updated readme

## [1.0.0] - 2020-06-20
### Added
- Creation of MultiSelect package
- Widgets include with MultiSelectListDialog, MultiSelectChipDialog, MultiSelectChipDisplay, 
MultiSelectField, MultiSelectFormField.
