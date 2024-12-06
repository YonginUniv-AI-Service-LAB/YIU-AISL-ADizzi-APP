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
  final List<String> _searchData = [
    '야구공',
    '야구모자',
    '배트',
    '축구공',
    '농구공',
    '탁구공',
    '야구장',
    '축구장',
  ];
  final List<String> _searchItemImg = [
    'assets/images/b.jpg',
    'assets/images/b.jpg',
    'assets/images/b.jpg',
    'assets/images/b.jpg',
    'assets/images/b.jpg',
    'assets/images/b.jpg',
    'assets/images/b.jpg',
    'assets/images/b.jpg',
  ];

  List<String> _filteredData = [];
  List<String> _filteredImg = [];

  @override
  void initState() {
    super.initState();
    _filteredData = List.from(_searchData); // 처음에는 모든 데이터를 표시
    _searchController.addListener(_filterSearchResults);
  }

  void _filterSearchResults() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      // 검색어와 일치하는 항목들만 필터링
      _filteredData = _searchData
          .where((item) => item.toLowerCase().contains(query))
          .toList();

      // 필터된 데이터에 맞춰 이미지를 업데이트
      _filteredImg = _filteredData.map((data) {
        final index = _searchData.indexOf(data);
        return _searchItemImg[index]; // 검색된 데이터에 해당하는 이미지,
      }).toList();
    });
  }

  void _clearSearchData() {
    setState(() {
      _searchData.clear(); // 최근 검색어 전체 삭제
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
              // 해당 키워드 입력시 아이템 페이지로 이동
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
          _searchController.text.isEmpty // 텍스트가 비어있을 때만 보여짐
              ? const DeleteRecent()
              : const SizedBox.shrink(),
          Expanded(
            child: SearchList(
              searchData: _filteredData,
              searchItemImg: _filteredImg, // 필터된 이미지 리스트 전달
            ),
          ),
        ],
      ),
    );
  }
}
