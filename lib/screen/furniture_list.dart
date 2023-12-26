import 'package:flutter/material.dart';
import 'home_Screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(FurnitureApp());
}

class FurnitureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FurnitureListPage(),
    );
  }
}

class Furniture {
  final String name;
  final String description;
  final String imageUrl;

  Furniture({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

class FurnitureListPage extends StatelessWidget {
  final List<Furniture> furnitureList = [
    Furniture(
      name: 'Sofa',
      description: 'Comfortable and stylish sofa',
      imageUrl:
          'https://via.placeholder.com/150', // Replace with actual image URL
    ),
    Furniture(
      name: 'Coffee Table',
      description: 'Wooden coffee table with storage',
      imageUrl:
          'https://via.placeholder.com/150', // Replace with actual image URL
    ),
    Furniture(
      name: 'Bookshelf',
      description: 'Tall bookshelf for your books',
      imageUrl:
          'https://via.placeholder.com/150', // Replace with actual image URL
    ),
    // Add more furniture items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Furniture List',
          style: GoogleFonts.bebasNeue(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: furnitureList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(furnitureList[index].imageUrl),
            ),
            title: Text(furnitureList[index].name),
            subtitle: Text(furnitureList[index].description),
            // You can add more details or actions for each furniture item here
            // For example, onTap to navigate to a details page
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => FurnitureDetailsPage(furniture: furnitureList[index]),
            //     ),
            //   );
            // },
          );
        },
      ),
    );
  }
}
