import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/providers/recipe_provider.dart';
import 'package:receipe_app/screens/recipe_result_screen.dart';
import 'package:receipe_app/widgets/loading_meal_widget.dart'; // Import the LoadingMealWidget

class RecipeScreen extends StatefulWidget {
  final List<String> ingredients;
  final String cuisine;

  RecipeScreen({Key? key, required this.ingredients, required this.cuisine})
      : super(key: key);

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipe for ${widget.cuisine}',
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: const Color.fromARGB(185, 66, 235, 229),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/${widget.cuisine.toLowerCase()}.png'), // Ensure these images exist
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: _isLoading
                ? const LoadingMealWidget() // Show LoadingMealWidget when _isLoading is true
                : ElevatedButton.icon(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        await recipeProvider.fetchRecipe(
                            widget.ingredients, widget.cuisine);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeResultScreen(
                              recipe: recipeProvider.recipe,
                              cuisine: widget.cuisine,
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to load recipe: $e')),
                        );
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    label: const Text('Generate Recipe'),
                    icon: const Icon(Icons.restaurant_menu),
                  ),
          ),
        ],
      ),
    );
  }
}
