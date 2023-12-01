import 'package:flutter/material.dart';

class PetDetailsPage extends StatelessWidget {
  final Map<String, dynamic> petData;

  PetDetailsPage({required this.petData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(petData['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (petData['photos'] != null && petData['photos'].isNotEmpty)
              Image.network(
                petData['photos'][0],
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16.0),
            Text(
              'Breed: ${petData['breed']}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Description: ${petData['description']}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            // Agrega más información según sea necesario
          ],
        ),
      ),
    );
  }
}
