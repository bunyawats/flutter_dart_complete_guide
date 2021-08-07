import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places_provider.dart';
import 'add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final greatPlaceProvider = Provider.of<GreatPlaceProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Place'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
          future: greatPlaceProvider.fetchAndSetPlaces(),
          builder: (ctx, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaceProvider>(
                    child: Center(
                      child:
                          const Text('Got no places yet, start adding some!'),
                    ),
                    builder: (ctx, greatPlaces, ch) =>
                        greatPlaces.items.length == 0
                            ? ch!
                            : ListView.builder(
                                itemCount: greatPlaces.items.length,
                                itemBuilder: (ctx, index) {
                                  final place = greatPlaces.items[index];

                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(place.image),
                                    ),
                                    title: Text(place.title),
                                    onTap: () {},
                                  );
                                },
                              ),
                  );
          }),
    );
  }
}
