import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/model.dart';

class SearchResultsScreen extends StatelessWidget {
  final List<ItemModel> searchResults;

  const SearchResultsScreen({Key? key, required this.searchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('검색 결과')),
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
