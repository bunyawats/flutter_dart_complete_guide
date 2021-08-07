import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/places_list_screen.dart';
import 'providers/graat_places_provider.dart';

void main() => runApp(GreatPlaceApp());

class GreatPlaceApp extends StatelessWidget {
  const GreatPlaceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData(
      primarySwatch: Colors.indigo,
    );

    return ChangeNotifierProvider.value(
      value: GreatPlaceProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: themeData.copyWith(
          colorScheme: themeData.colorScheme.copyWith(secondary: Colors.amber),
        ),
        home: PlacesListScreen(),
      ),
    );
  }
}
