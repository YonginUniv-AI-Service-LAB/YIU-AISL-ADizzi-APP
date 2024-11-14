import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchList extends StatelessWidget {
  final List<String> searchData;

  const SearchList({super.key, required this.searchData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchData.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.restore),
          title: Text(
            searchData[index],
            style: const TextStyle(color: Colors.black, fontSize: 16),

          ),
          trailing: const Icon(Icons.clear),
        );
      },
    );
  }
}
