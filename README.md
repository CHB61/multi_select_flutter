# Multi Select Flutter

Multi Select Flutter is a package for easily creating multi-select widgets in a variety of ways.

<img src="https://i.imgur.com/lNOkPtg.gif" alt="drawing" width="200"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://i.imgur.com/7ME7xZ5.gif" alt="drawing" width="200"/>

## Features
- Can use MultiSelectFormField for use with validators and other FormField methods.
- Neutral default design that can be altered to your heart's content.
- Easily switch the MultiSelectField's 'dialogType' from LIST to CHIP.
- Separate widget for MultiSelectChipDisplay that has the ability to delete from the selected items list when a chip item is tapped.
- Separate widgets for MultiSelectListDialog / MultiSelectChipDialog that you can simply use in the builder of showDialog(), and can be triggered with your own button.

## Install
Add this to your pubspec.yaml file:
```javascript
dependencies:
  multi_select_flutter: ^1.0.4
```

## Usage

#### MultiSelectListDialog / MultiSelectChipDialog

These widgets can be used in the builder of showDialog().

```javascript
  void _showMultiSelectDialog(BuildContext context) async {
    _selectedItems = await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectListDialog(
          items: _items.map((item) => 
            MultiSelectItem(item, item.name)).toList(),
          title: "Dialog Title",
          initialSelectedItems: _selectedItems,
        );
      },
    );
  }

```
#### MultiSelectChipDisplay
This widget can be used by itself, alongside one of the dialogs, or it can be specified as a parameter of *MultiSelectField / MultiSelectFormField*.

To use this widget effectively, make sure to set the state when the list of items is changed.

You can also remove items from the source list in the onTap function.

```javascript

MultiSelectChipDisplay(
  items: _selectedItems.map((item) => 
    MultiSelectItem(item, item.name)).toList(),
  onTap: (item) {
    setState(() {
      _selectedItems.remove(item);
    });
  },
),
```
#### MultiSelectField
*MultiSelectField* provides a button which opens the dialog.
To save the values from the dialog using this widget, an **onConfirm(values)** function is provided.

```javascript
MultiSelectField(
  title: "Animals",
  buttonText: "Favorite Animals"
  items: dialogItems,
  dialogType: MultiSelectDialogType.CHIP,
  decoration: BoxDecoration(
    color: Theme.of(context).primaryColor.withOpacity(.4),
    border: Border.all(
      color: Theme.of(context).primaryColor,
    ),
  ),
  textStyle: TextStyle(fontSize: 20),
  onConfirm: (results) {
    setState(() {
      _selectedAnimals = results;
    });
  },
),
``` 

#### MultiSelectFormField
*MultiSelectFormField* is the FormField version of *MultiSelectField*. You can put it into a form and make use of FormField parameters such as *validator* and *onSaved*.

It also comes with a default bottom-border that can be overriden with the **decoration** parameter.

```javascript
Form(
  child: MultiSelectFormField(
    key: _formFieldKey,
    buttonIcon: Icon(Icons.arrow_forward_ios),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Required";
      }
      return null;
    },
    title: "Animals",
    items: items,
    dialogType: MultiSelectDialogType.CHIP,
    onConfirm: (values) {
      _selectedAnimalItems = values;
      _formFieldKey.currentState.validate();
    },
    chipDisplay: MultiSelectChipDisplay(
      items: _selectedAnimalItems,
    ),
  ),
),
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
