import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_dialog_field_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Multi Select',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Multi Select'),
    );
  }
}

class Animal {
  final int id;
  final String name;

  Animal({
    this.id,
    this.name,
  });
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
    Animal(id: 8, name: "Snake"),
    Animal(id: 9, name: "Bear"),
    Animal(id: 10, name: "Beaver"),
    Animal(id: 11, name: "Cat"),
    Animal(id: 12, name: "Fish"),
    Animal(id: 13, name: "Rabbit"),
    Animal(id: 14, name: "Mouse"),
    Animal(id: 15, name: "Dog"),
    Animal(id: 16, name: "Zebra"),
    Animal(id: 17, name: "Cow"),
    Animal(id: 18, name: "Frog"),
    Animal(id: 19, name: "Blue Jay"),
    Animal(id: 20, name: "Moose"),
    Animal(id: 21, name: "Gecko"),
    Animal(id: 22, name: "Kangaroo"),
    Animal(id: 23, name: "Shark"),
    Animal(id: 24, name: "Crocodile"),
    Animal(id: 25, name: "Owl"),
    Animal(id: 26, name: "Dragonfly"),
    Animal(id: 27, name: "Dolphin"),
  ];

  final _items = _animals.map((animal) => MultiSelectItem<Animal>(animal, animal.name)).toList();
  final _multiSelectKey = GlobalKey<FormFieldState>();

  MultiSelectDialogFieldController<Animal> controller = MultiSelectDialogFieldController<Animal>();
  MultiSelectDialogFieldController<Animal> controller2 = MultiSelectDialogFieldController<Animal>();
  MultiSelectDialogFieldController<Animal> controller3 = MultiSelectDialogFieldController<Animal>();
  MultiSelectDialogFieldController<Animal> controller4 = MultiSelectDialogFieldController<Animal>();
  MultiSelectDialogFieldController<Animal> controller5 = MultiSelectDialogFieldController<Animal>();
  List<Animal> _animals5 = [];

  @override
  void initState() {
    _animals5 = _animals.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              //################################################################################################
              // Rounded blue MultiSelectDialogField
              //################################################################################################
              MultiSelectDialogField(
                items: _items,
                title: Text("Animals"),
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.pets,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  "Favorite Animals",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                chipDisplay: MultiSelectChipDisplay<Animal>(),
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        controller.selectedItems.clear();
                      });
                    },
                    child: Text("Clear selection"),
                  ),
                ],
              ),
              SizedBox(height: 50),
              //################################################################################################
              // This MultiSelectBottomSheetField has no decoration, but is instead wrapped in a Container that has
              // decoration applied. This allows the ChipDisplay to render inside the same Container.
              //################################################################################################
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.4),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    MultiSelectBottomSheetField<Animal>(
                      initialChildSize: 0.4,
                      listType: MultiSelectListType.CHIP,
                      searchable: true,
                      buttonText: Text("Favorite Animals"),
                      title: Text("Animals"),
                      items: _items,
                      onConfirm: (List<Animal> values) {
                        setState(() {
                          controller2.selectedItems = values;
                        });
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (value) {
                          setState(() {
                            controller2.selectedItems.remove(value);
                          });
                        },
                      ),
                    ),
                    controller2.selectedItems == null || controller2.selectedItems.isEmpty
                        ? Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "None selected",
                              style: TextStyle(color: Colors.black54),
                            ))
                        : Container(),
                  ],
                ),
              ),
              SizedBox(height: 40),
              //################################################################################################
              // MultiSelectBottomSheetField with validators
              //################################################################################################
              MultiSelectBottomSheetField<Animal>(
                key: _multiSelectKey,
                initialChildSize: 0.7,
                maxChildSize: 0.95,
                title: Text("Animals"),
                buttonText: Text("Favorite Animals"),
                items: _items,
                searchable: true,
                validator: (values) {
                  if (values == null || values.isEmpty) {
                    return "Required";
                  }
                  List<String> names = values.map((e) => e.name).toList();
                  if (names.contains("Frog")) {
                    return "Frogs are weird!";
                  }
                  return null;
                },
                onConfirm: (values) {
                  setState(() {
                    controller3.selectedItems = values;
                  });
                  _multiSelectKey.currentState.validate();
                },
                chipDisplay: MultiSelectChipDisplay(
                  onTap: (item) {
                    setState(() {
                      controller3.selectedItems.remove(item);
                    });
                    _multiSelectKey.currentState.validate();
                  },
                ),
              ),
              SizedBox(height: 40),
              //################################################################################################
              // MultiSelectChipField
              //################################################################################################
              MultiSelectChipField<Animal>((
                items: _items,
                initialValue: _animals5,
                title: Text("Animals"),
                headerColor: Colors.blue.withOpacity(0.5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[700], width: 1.8),
                ),
                selectedChipColor: Colors.blue.withOpacity(0.5),
                selectedTextStyle: TextStyle(color: Colors.blue[800]),
                onTap: (values) {
                  //_selectedAnimals4 = values;
                },
              ),
              SizedBox(height: 40),
              //################################################################################################
              // MultiSelectDialogField with initial values
              //################################################################################################
              MultiSelectDialogField<Animal>(
                items: _items,
                initialValue: _animals5, // setting the value of this in initState() to pre-select values.
                chipDisplay: MultiSelectChipDisplay<Animal>(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
