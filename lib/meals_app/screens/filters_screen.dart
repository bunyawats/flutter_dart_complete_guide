import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function _saveFilter;
  final Map<String, bool> _currentFilters;

  FilterScreen({filters, saveFilter})
      : _currentFilters = filters,
        _saveFilter = saveFilter;

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late bool _glutenFree;
  late bool _vegetarian;
  late bool _vegan;
  late bool _lactoseFree;

  @override
  void initState() {
    _glutenFree = widget._currentFilters['gluten'] ?? false;
    _vegetarian = widget._currentFilters['vegetarian'] ?? false;
    _vegan = widget._currentFilters['vegan'] ?? false;
    _lactoseFree = widget._currentFilters['lactose'] ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget._saveFilter(selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  title: 'Gluten-free',
                  subTitle: 'Only include gluten-free meals.',
                  value: _glutenFree,
                  updateValue: (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  title: 'Lactose-Free',
                  subTitle: 'Only include lactose-free meals.',
                  value: _lactoseFree,
                  updateValue: (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  title: 'Vegetarian',
                  subTitle: 'Only include vegetarian meals.',
                  value: _vegetarian,
                  updateValue: (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  title: 'Vegan',
                  subTitle: 'Only include vegan meals.',
                  value: _vegan,
                  updateValue: (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SwitchListTile _buildSwitchListTile({
    required String title,
    required String subTitle,
    required bool value,
    required Function(bool) updateValue,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(
        subTitle,
      ),
    );
  }
}
