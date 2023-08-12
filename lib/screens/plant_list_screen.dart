import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PlantListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GridViewScreen(),
    );
  }
}

class GridViewScreen extends StatelessWidget {
  final List<GridItem> gridItems = [
    GridItem(
      image: AssetImage('assets/image1.png'),
      text: 'Cactus',
      route: '/item1',
    ),
    GridItem(
      image: AssetImage('assets/image2.png'),
      text: 'Flowers',
      route: '/item2',
    ),
    // Add more grid items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plants')),
      body: GridView.builder(
        itemCount: gridItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, gridItems[index].route);
            },
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: gridItems[index].image,
                      fit: BoxFit.cover, // Set fit to BoxFit.cover
                    ),
                    SizedBox(height: 10),
                    Text(gridItems[index].text),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GridItem {
  final ImageProvider image;
  final String text;
  final String route;

  GridItem({required this.image, required this.text, required this.route});
}
