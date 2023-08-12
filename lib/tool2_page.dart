import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'recipe_detail_page.dart';

class Tool2Page extends StatefulWidget {
  @override
  _Tool2PageState createState() => _Tool2PageState();
}

class _Tool2PageState extends State<Tool2Page> {
  List results = [];
  TextEditingController _controller = TextEditingController();

  Future<void> searchRecipes(String query) async {
    final String url = 'https://api.spoonacular.com/recipes/complexSearch?query=$query&apiKey=95f82a95c33f4687af51f4e562e6b55c&includeNutrition=true';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        results = data['results'];
      });
    } else {
      print('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Finder Tool'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search for a recipe...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => searchRecipes(_controller.text),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(results[index]['image']),
                  title: Text(results[index]['title']),
                  trailing: Text(results[index]['id'].toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(recipeId: results[index]['id']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
