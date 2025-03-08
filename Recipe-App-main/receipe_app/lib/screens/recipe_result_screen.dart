import 'package:flutter/material.dart';
import 'package:receipe_app/screens/ingredient_screen.dart';

class RecipeResultScreen extends StatelessWidget {
  final String recipe;
  final String cuisine;

  RecipeResultScreen({Key? key, required this.recipe, required this.cuisine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe Result',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Color.fromARGB(185, 66, 235, 229),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background3.png'), // Ensure these images exist
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color:
                Colors.black.withOpacity(0.5), // Adjust the opacity as needed
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        recipe,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      if (recipe.length >
                          500) // Example condition for large text
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IngredientScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text('Start Fresh'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
