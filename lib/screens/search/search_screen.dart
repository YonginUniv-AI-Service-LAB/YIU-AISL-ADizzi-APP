import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/service/search.dart';
import '../../utils/model.dart';
import '../../widgets/delete_recent.dart';
import '../../widgets/search_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ItemModel>? items;
  String _query = '';

  @override
  void initState() {
    super.initState();
  }

  // 비동기적으로 아이템 데이터 로드
  Future<void> _loadItemData(String query) async {
    // 검색어가 비어있지 않은 경우에만 검색
    if (query.isNotEmpty) {
      print('검색어: $_query');
      items = await getSearch(context, query: query);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: TextField(
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _query = value;
            });
            _loadItemData(value); // 실시간으로 검색어에 맞는 데이터 로드
          },
          decoration: InputDecoration(
            hintText: '검색어를 입력해주세요',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black54, fontSize: 17),
          ),
          style: TextStyle(color: Colors.black87),
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadItemData(_query); // 버튼을 눌렀을 때도 검색
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
            child: items == null || items!.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SearchList(searchData: items!),
          ),
        ],
      ),
    );
  }
}
