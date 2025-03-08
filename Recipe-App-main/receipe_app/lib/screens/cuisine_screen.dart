import 'package:flutter/material.dart';
import 'package:receipe_app/screens/recipe_screen.dart';

class CuisineScreen extends StatelessWidget {
  final List<String> ingredients;

  CuisineScreen({Key? key, required this.ingredients}) : super(key: key);

  final List<Map<String, dynamic>> cuisines = [
    {
      'name': 'Greek',
      'image': 'assets/images/greek.png',
      'aspectRatio': 0.75, // Replace with your image asset path
    },
    {
      'name': 'Thai',
      'image': 'assets/images/thai.png',
      'aspectRatio': 0.75, // Replace with your image asset path
    },
    {
      'name': 'Italian',
      'image': 'assets/images/italian.png',
      'aspectRatio': 0.75, // Replace with your image asset path
    },
    {
      'name': 'Mexican',
      'image': 'assets/images/mexican.png',
      'aspectRatio': 0.75, // Replace with your image asset path
    },
    {
      'name': 'Indian',
      'image': 'assets/images/indian.png',
      'aspectRatio': 0.5, // Replace with your image asset path
    },
    // Add more cuisines as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Select Cuisine',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          ),
          backgroundColor: const Color.fromARGB(185, 66, 235, 229)),
      body: Stack(
        children: [
          // Background image for the entire screen
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png', // Replace with your background image asset path
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          // Grid view of cuisines
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75, // Aspect ratio of each grid item
              ),
              itemCount: cuisines.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeScreen(
                          ingredients: ingredients,
                          cuisine: cuisines[index]['name'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(cuisines[index]['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.2), // Dark overlay
                      ),
                      child: Center(
                        child: Text(
                          cuisines[index]['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
