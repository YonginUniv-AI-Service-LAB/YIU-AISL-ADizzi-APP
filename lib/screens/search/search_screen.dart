import 'package:flutter/material.dart';
import '../../widgets/delete_recent.dart';
import '../../widgets/search_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchedItems = [];  // 검색된 항목들을 저장할 배열

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addSearchItem(String item) {
    setState(() {
      _searchedItems.add(item);
    });
  }

  void _removeSearchItem(String item) {
    setState(() {
      _searchedItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '검색어를 입력해주세요',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black54, fontSize: 17),
          ),
          style: const TextStyle(color: Colors.black87),
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                _addSearchItem(_searchController.text);  // 검색어 배열에 추가
              }
            },
          ),
        ],
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFF5DDA6F),
          ),
        ),
      ),
      body: Column(
        children: [
         const DeleteRecent(),
          Expanded(
            child: SearchList(
              searchData: _searchedItems,
              onRemove: _removeSearchItem,  // 삭제
            ),
          ),
        ],
      ),
    );
  }
}
