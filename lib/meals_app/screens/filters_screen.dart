import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
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
    String title,
    String subTitle,
    bool value,
    Function updateValue,
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
