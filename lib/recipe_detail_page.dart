import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeDetailPage extends StatefulWidget {
  final int recipeId;
  RecipeDetailPage({required this.recipeId});

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  Map<String, dynamic> recipeDetails = {};

  @override
  void initState() {
    super.initState();
    getRecipeDetails();
  }

  Future<void> getRecipeDetails() async {
    final String apiKey = '95f82a95c33f4687af51f4e562e6b55c';
    final String url = 'https://api.spoonacular.com/recipes/${widget.recipeId}/information?apiKey=$apiKey&includeNutrition=true';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        recipeDetails = data;
      });
    } else {
      print('Failed to load recipe details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: recipeDetails.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title: ${recipeDetails['title']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 8),
                    Text('Cooking Time: ${recipeDetails['readyInMinutes']} minutes', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Servings: ${recipeDetails['servings']}', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Divider(),
                    Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: recipeDetails['extendedIngredients']?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Text(
                          recipeDetails['extendedIngredients'][index]['original'],
                          style: TextStyle(fontSize: 16),
                        );
                      },
                    ),
                    // Add more fields as needed
                  ],
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
