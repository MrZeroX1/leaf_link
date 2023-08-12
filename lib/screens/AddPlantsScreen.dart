import 'package:flutter/material.dart';

class AddPlantsScreen extends StatelessWidget {
  final List<String> allPlants = [
    'Plant A',
    'Plant B',
    'Plant C', /* ... */
  ]; // Example list of all available plants

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Plants')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: allPlants.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Add plant to user's list logic
            },
            child: Card(
              child: Column(
                children: [
                  Text(allPlants[index]),
                  Image.asset(
                      'assets/${allPlants[index].toLowerCase()}.png'), // Assuming image files are named after plant names
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
