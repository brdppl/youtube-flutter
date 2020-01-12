import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = List();
    if(query.isNotEmpty) {
      suggestions = [
        'Android', 'Google', 'Flutter', 'Dart', 'Kotlin', 'Java', 'Inteligencia Artificial', 'Google Maps', 'Maps', 'API', 'iOS', 'Google Chrome', 'Chrome'
      ].where(
        (text) => text.toLowerCase().startsWith(query.toLowerCase())
      ).toList();

      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestions[index]),
            onTap: () {
              close(context, suggestions[index]);
            },
          );
        },
      );
    } else {
      return Center(
        child: Text('Digite um termo para sua pesquisa.'),
      );
    }
  }
}