import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/search/search_screen.dart';

import '../../utils/model.dart';

class SearchResultsScreen extends StatelessWidget {
  final List<ItemModel> searchResults;

  final String query;


  const SearchResultsScreen({Key? key, required this.searchResults, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(query), actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
            );
          },
        ),
      ]
        ,),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          ItemModel item = searchResults[index];
          return ListTile(
            title: Text(item.title ?? 'No title'),
            subtitle: Text(item.detail ?? 'No details'),
          );
        },
      ),
    );
  }
}
