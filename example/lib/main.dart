import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  List<Animal> _selectedAnimals = [];
  List<Animal> _selectedAnimals2 = [];
  List<Animal> _selectedAnimals3 = [];
  final _formKey = GlobalKey<FormState>();

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
              Container(
                width: 300,
                //################################################################################################
                // MultiSelectDialogField
                //################################################################################################
                child: MultiSelectDialogField(
                  items: _items,
                  title: Text("Animals"),
                  searchable: true,
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
                  onConfirm: (results) {
                    setState(() {
                      _selectedAnimals = results;
                    });
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    chipColor: Colors.lightBlue[100],
                    textStyle: TextStyle(color: Colors.blue),
                    items: _selectedAnimals
                        .map((e) => MultiSelectItem<Animal>(e, e.name))
                        .toList(),
                    onTap: (value) {
                      setState(() {
                        _selectedAnimals.remove(value);
                      });
                    },
                  ),
                ),
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
                width: 300,
                child: Column(
                  children: <Widget>[
                    MultiSelectBottomSheetField(
                      initialChildSize: 0.40,
                      listType: MultiSelectListType.CHIP,
                      searchable: true,
                      buttonText: Text("Favorite Animals"),
                      title: Text("Animals"),
                      items: _items,
                      onConfirm: (results) {
                        setState(() {
                          _selectedAnimals2 = results;
                        });
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        items: _selectedAnimals2
                            .map((e) => MultiSelectItem<Animal>(e, e.name))
                            .toList(),
                        onTap: (value) {
                          setState(() {
                            _selectedAnimals2.remove(value);
                          });
                        },
                      ),
                    ),
                    _selectedAnimals2 == null || _selectedAnimals2.isEmpty
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
              // MultiSelectBottomSheetFormField with validators
              //################################################################################################
              Form(
                key: _formKey,
                child: MultiSelectBottomSheetField(
                  initialChildSize: 0.8,
                  maxChildSize: 0.95,
                  title: Text("Animals"),
                  buttonText: Text("Favorite Animals"),
                  items: _items,
                  searchable: true,
                  buttonIcon: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    if (value.contains("Frog")) {
                      return "Frogs are weird!";
                    }
                    return null;
                  },
                  onConfirm: (values) {
                    _formKey.currentState.validate();
                    setState(() {
                      _selectedAnimals3 = values;
                    });
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (item) {
                      setState(() {
                        _selectedAnimals3.remove(item);
                        _formKey.currentState.validate();
                      });
                    },
                    items: _selectedAnimals3
                        .map((e) => MultiSelectItem(e, e.name))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 40),
              RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  _formKey.currentState.validate();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
