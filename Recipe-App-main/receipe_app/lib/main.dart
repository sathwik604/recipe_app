import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:receipe_app/providers/recipe_provider.dart';
import 'package:receipe_app/screens/ingredient_screen.dart';
import 'package:receipe_app/screens/welcome_screen.dart';
import 'package:receipe_app/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBGKRjEjRZWggADhGj9h8XqkDMUpD-tItc",
          appId: "1:727757555385:android:0da1808039936edebbbd68",
          messagingSenderId: "727757555385",
          projectId: "recipe-app-b9e3d"));
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthWrapper(),
      routes: {
        '/sign-in': (context) => SignInScreen(),
        '/ingredient-screen': (context) => IngredientScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    return firebaseUser == null ? SignInScreen() : WelcomeScreen();
  }
}
