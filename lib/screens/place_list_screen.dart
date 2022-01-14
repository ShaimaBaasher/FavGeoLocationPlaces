import 'package:flutter/material.dart';
import 'package:great_places/providers/places_provider.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

import 'detials_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("your Places"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<PlacesProvider>(
                    builder: (ctx, provider, child) {
                      return provider.items.length <= 0
                          ? child
                          : ListView.builder(
                              itemCount: provider.items.length,
                              itemBuilder: (ctx, i) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(provider.items[i].image),
                                  ),
                                  title: Text(provider.items[i].title),
                                  subtitle:
                                      Text(provider.items[i].location.address),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        DetialScreen.routeName,
                                        arguments: provider.items[i].id);
                                  },
                                );
                              });
                    },
                    child: Center(
                      child: Text("Got Not Places, start adding some !"),
                    ),
                  ),
      ),
    );
  }
}
