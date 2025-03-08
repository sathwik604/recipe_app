import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeProvider with ChangeNotifier {
  String _recipe = '';

  String get recipe => _recipe;
  final apikey = dotenv.env['token'];

  Future<void> fetchRecipe(List<String> ingredients, String cuisine) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apikey!,
    );
    final prompt = _generatePrompt(ingredients, cuisine);

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      _recipe = response.text!;
      await _saveRecipeToFirebase(ingredients, cuisine, _recipe);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load recipe: $e');
    }
  }

  void clearRecipe() {
    _recipe = '';
    notifyListeners();
  }

  String _generatePrompt(List<String> ingredients, String cuisine) {
    String prompt =
        'Generate a $cuisine recipe with the following ingredients: ${ingredients.join(", ")}';

    return prompt;
  }

  Future<void> _saveRecipeToFirebase(
      List<String> ingredients, String cuisine, String recipe) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('recipes')
            .add({
          'ingredients': ingredients,
          'cuisine': cuisine,
          'recipe': recipe,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        throw Exception('Failed to save recipe: $e');
      }
    }
  }
}
