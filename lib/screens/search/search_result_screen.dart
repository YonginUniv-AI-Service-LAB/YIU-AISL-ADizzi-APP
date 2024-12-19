import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/screens/search/search_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/search_service.dart';

import '../../provider/tree_provider.dart';
import '../../utils/model.dart';
import '../../widgets/item_card.dart';

class SearchResultsScreen extends StatefulWidget {
  final List<ItemModel> searchResults;
  final String query;

  const SearchResultsScreen({
    Key? key,
    required this.searchResults,
    required this.query,
  }) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late List<ItemModel> searchResults;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    // searchResults = widget.searchResults;
    Provider.of<TreeProvider>(context, listen: false).fetchTree(context);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      searchResults = await getSearch(context, query: widget.query);
      // await Provider.of<TreeProvider>(context, listen: false).fetchTree(context);
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // 로딩 중
      );
    }

    if (_error != null) {
      return Center(
        child: Text(
          "에러 발생: $_error",
          style: const TextStyle(color: Colors.red),
        ),
      ); // 에러 처리
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.query),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: searchResults.isEmpty
            ? const Center(
          child: Text(
            "검색 결과가 없습니다",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        )
            : buildSearchResultsList(),
      ),
    );
  }

  Widget buildSearchResultsList() {
    final treeProvider = Provider.of<TreeProvider>(context, listen: true);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "결과",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          color: Colors.black12,
          indent: 10,
          endIndent: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final item = searchResults[index];
              final path = treeProvider.getPathBySlotId(item.slotId!);

              return buildListItem(item, path);
            },
          ),
        ),
      ],
    );
  }

  Widget buildListItem(ItemModel item, String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          item.title!,
          style: const TextStyle(fontSize: 17, color: Colors.black),
        ),
        subtitle: Text(
          path,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        leading: item.imageUrl != null
            ? Image.network(
          item.imageUrl!,
          width: 40,
          height: 50,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Container(
                color: Colors.black12,
                width: 40,
                height: 50,
              );
            }
          },
        )
            : Container(
          width: 40,
          height: 50,
          color: Colors.black12,
          child: const Icon(Icons.image_not_supported),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ItemCard(item: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}