# Multi Select Flutter

Multi Select Flutter is a package for easily creating multi-select widgets in a variety of ways.

<img src="https://i.imgur.com/Tl7VjCc.gif" alt="drawing" width="200"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://i.imgur.com/7ME7xZ5.gif" alt="drawing" width="200"/>

## Usage

#### MultiSelectListDialog / MultiSelectChipDialog

These widgets can be used in the builder of showDialog().

```javascript
  void _showMultiSelectDialog(BuildContext context) async {
    _selectedItems = await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectListDialog<int>(
          items: _Items.map((item) => 
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

```

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

```
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
*MultiSelectFormField* is the FormField version of *MultiSelectField*. You can put it into a form and make use of FormField methods such as validate() and onSave().

It also comes with a default bottom-border that can be overriden with the **decoration** parameter.

```
Form(
  key: _formKey,
  child: MultiSelectFormField(
    buttonIcon: Icon(Icons.arrow_forward_ios),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Required";
      }
      return null;
    },
    onSaved: (value) {
      _selectedAnimals = value;
    },
    title: "Animals",
    items: items,
    dialogType: MultiSelectDialogType.CHIP,
    onConfirm: (values) {
      _formKey.currentState.validate();
    },
    chipDisplay: MultiSelectChipDisplay(
      items: _selectedAnimalItems,
    ),
  ),
),
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
