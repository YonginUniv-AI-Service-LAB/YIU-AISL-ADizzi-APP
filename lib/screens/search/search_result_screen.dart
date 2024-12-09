import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/screens/search/search_screen.dart';

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

  @override
  void initState() {
    super.initState();
    searchResults = widget.searchResults;
    print('결과 $searchResults');
  }
  @override
  Widget build(BuildContext context) {
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
        child: widget.searchResults.isEmpty
            ? const Center(
          child: Text(
            "검색 결과가 없습니다",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        )
            : ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "검색 결과",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 3, bottom: 10),
                    child: Divider(
                      height: 1,
                      color: Color(0xFF48464C),
                    ),
                  ),
                  // 검색 결과 리스트 표시
                  for (var item in widget.searchResults)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(
                          item.title!,
                          style: const TextStyle(fontSize: 17, color: Colors.black),
                        ),
                        subtitle: Text(
                          Provider.of<TreeProvider>(
                            context,
                            listen: true,
                          ).getPathBySlotId(item.slotId!),
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
                          // 아이템 클릭 시 팝업 창 띄우기
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
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
