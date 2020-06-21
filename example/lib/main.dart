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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<String> _animals = [
    "Cat",
    "Rabbit",
    "Fish",
    "Mouse",
    "Dog",
    "Zebra",
    "Cow",
    "Frog",
    "Blue Jay"
  ];
  final items = _animals
      .map((animal) => MultiSelectItem<String>(animal, animal))
      .toList();
  List<String> _selectedAnimals;
  List<String> _selectedAnimals2;
  List<String> _selectedAnimals3;
  List<String> _selectedAnimals4;
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
                // MultiSelectField
                //################################################################################################
                child: MultiSelectField(
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
                  buttonText: "Favorite Animals",
                  title: "Animals",
                  items: items,
                  onConfirm: (results) {
                    setState(() {
                      _selectedAnimals = results;
                    });
                  },
                  textStyle: TextStyle(fontSize: 20, color: Colors.blue),
                  chipDisplay: MultiSelectChipDisplay(
                    chipColor: Colors.lightBlue[100],
                    textStyle: TextStyle(color: Colors.blue),
                    items: _selectedAnimals != null
                        ? _selectedAnimals
                            .map((e) => MultiSelectItem<String>(e, e))
                            .toList()
                        : [],
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
              // This MultiSelectField has no decoration, but is instead wrapped in a container that has
              // decoration applied. This allows the ChipDisplay to render inside the same container.
              //################################################################################################
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.4),
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 40)),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                width: 300,
                child: MultiSelectField(
                  buttonText: "Favorite Animals",
                  title: "Animals",
                  items: items,
                  onConfirm: (results) {
                    setState(() {
                      _selectedAnimals2 = results;
                    });
                  },
                  textStyle: TextStyle(fontSize: 20),
                  chipDisplay: MultiSelectChipDisplay<String>(
                    items: _selectedAnimals2 != null
                        ? _selectedAnimals2
                            .map((e) => MultiSelectItem<String>(e, e))
                            .toList()
                        : [],
                    onTap: (value) {
                      setState(() {
                        _selectedAnimals2.remove(value);
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 40),
              Form(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                  ),
                  //################################################################################################
                  // MultiSelectFormField
                  //################################################################################################
                  child: MultiSelectFormField<String>(
                    buttonText: "Favorite Animals",
                    textStyle: TextStyle(color: Colors.green),
                    decoration: BoxDecoration(),
                    onConfirm: (values) {
                      setState(() {
                        _selectedAnimals3 = values;
                      });
                    },
                    title: "Hello",
                    items: items,
                    chipDisplay: MultiSelectChipDisplay(
                      chipColor: Colors.green[100],
                      textStyle: TextStyle(color: Colors.green),
                      onTap: (item) {
                        setState(() {
                          _selectedAnimals3.remove(item);
                        });
                      },
                      items: _selectedAnimals3 != null
                          ? _selectedAnimals3
                              .map((e) => MultiSelectItem(e, e))
                              .toList()
                          : [],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              //################################################################################################
              // MultiSelectFormField with validators
              //################################################################################################
              Form(
                key: _formKey,
                child: MultiSelectFormField(
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
                  onSaved: (value) {
                    _selectedAnimals4 = value;
                  },
                  title: "Animals",
                  items: items,
                  dialogType: MultiSelectDialogType.CHIP,
                  onConfirm: (values) {
                    _formKey.currentState.validate();
                    setState(() {
                      _selectedAnimals4 = values;
                    });
                  },
                  buttonText: "Favorite Animals",
                  chipDisplay: MultiSelectChipDisplay(
                    onTap: (item) {
                      setState(() {
                        _selectedAnimals4.remove(item);
                        _formKey.currentState.validate();
                      });
                    },
                    items: _selectedAnimals4 != null
                        ? _selectedAnimals4
                            .map((e) => MultiSelectItem(e, e))
                            .toList()
                        : [],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
