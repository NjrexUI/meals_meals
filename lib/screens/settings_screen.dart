import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/settings";

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  SettingsScreen(this.currentFilters, this.saveFilters);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool glutenFree = false;
  bool isVegetarian = false;
  bool isVegan = false;
  bool lactoseFree = false;

  @override
  initState() {
    glutenFree = widget.currentFilters["gluten"];
    lactoseFree = widget.currentFilters["lactose"];
    isVegan = widget.currentFilters["vegan"];
    isVegetarian = widget.currentFilters["vegetarian"];
    super.initState();
  }

  Widget buildFilterSwitchListTile(
    String title,
    String subtitle,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                "gluten": glutenFree,
                "lactose": lactoseFree,
                "vegan": isVegan,
                "vegetarian": isVegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection:",
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildFilterSwitchListTile(
                  "Gluten-free",
                  "Only includes gluten-free meals.",
                  glutenFree,
                  (newValue) {
                    setState(
                      () {
                        glutenFree = newValue;
                      },
                    );
                  },
                ),
                buildFilterSwitchListTile(
                  "Lactose-free",
                  "Only includes lactose-free meals.",
                  lactoseFree,
                  (newValue) {
                    setState(
                      () {
                        lactoseFree = newValue;
                      },
                    );
                  },
                ),
                buildFilterSwitchListTile(
                  "Vegetarian",
                  "Only includes vegetarian meals.",
                  isVegetarian,
                  (newValue) {
                    setState(
                      () {
                        isVegetarian = newValue;
                      },
                    );
                  },
                ),
                buildFilterSwitchListTile(
                  "Vegan",
                  "Only includes vegan meals.",
                  isVegan,
                  (newValue) {
                    setState(
                      () {
                        isVegan = newValue;
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
