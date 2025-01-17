import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yiu_aisl_adizzi_app/screens/search/search_result_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/search_service.dart';

import '../../service/item_service.dart';
import '../../utils/model.dart';
import '../../widgets/delete_recent.dart';
import '../../widgets/search_detail_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ItemModel>? items;
  List<ItemModel> _searchedItems = []; // 검색된 아이템 리스트
  bool _isLoading = false; // 로딩 상태를 관리
  List<String> recentSearches = []; // 최근 검색어 리스트

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // 최근 검색어 로컬 저장소에서 불러오기
  void _loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recent_searches') ?? [];
    });
  }

  // 최근 검색어 로컬 저장소에 저장하기
  void _saveRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recent_searches', recentSearches);
  }

  // 검색어를 입력하면 getSearch 호출
  Future<void> _searchItems(String query) async { // 반환 타입을 Future<void>로 변경
    setState(() {
      _isLoading = true;
      _searchedItems = [];
    });

    try {
      List<ItemModel> items = await getSearch(context, query: query);

      // 아이템들 중에서 title에 query가 포함된 항목만 필터링
      List<ItemModel> searchResults = items.where((item) {
        return item.title != null &&
            item.title!.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        _searchedItems = searchResults; // 검색 결과 업데이트
        _isLoading = false; // 로딩 완료
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // 오류 처리 (필요 시 SnackBar 등으로 안내)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('검색에 실패했습니다.')),
      );
    }
  }

  // 최근 검색어 삭제 처리 함수
  void _deleteRecentSearch(int index) {
    setState(() {
      recentSearches.removeAt(index); // 최근 검색어 삭제
      _saveRecentSearches(); // 삭제 후 로컬 저장소에 반영
    });
  }

  // 최근 검색어 추가 처리 함수
  void _addRecentSearch(String query) {
    if (!recentSearches.contains(query)) {
      setState(() {
        recentSearches.insert(0, query); // 최근 검색어 맨 앞에 추가
        _saveRecentSearches(); // 추가 후 로컬 저장소에 반영
      });
    }
  }

  // 검색 결과 페이지로 네비게이션 (async로 변경)
  Future<void> _navigateToSearchResults() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SearchResultsScreen(searchResults: _searchedItems, query: _searchController.text),
      ),
    );
    // SearchResultsScreen에서 돌아온 후 검색 필드 비우기
    setState(() {
      _searchController.clear();
    });
  }

  Widget _buildSearchArea() {
    if (_searchController.text.isEmpty) {
      return Column(
        children: [
          const DeleteRecent(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: recentSearches.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Material(
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  String selectedQuery = recentSearches[index];
                                  _searchController.text = selectedQuery;


                                  _addRecentSearch(selectedQuery);

                                  await _searchItems(selectedQuery);
                                  await _navigateToSearchResults();
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.restore, size: 22),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        recentSearches[index],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                        ),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis, // 긴 텍스트 처리
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // clear 아이콘은 InkWell 외부에 배치
                            IconButton(
                              icon: const Icon(Icons.clear, size: 20),
                              onPressed: () {
                                _deleteRecentSearch(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    }
 else if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: _searchedItems.length,
              itemBuilder: (context, index) {
                ItemModel item = _searchedItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              _searchController.text = _searchedItems[index].title!;
                              _navigateToSearchResults();
                            },
                            child: ListTile(
                              title: Text(
                                item.title!,
                                style: const TextStyle(fontSize: 17),
                              ),
                              leading: item.imageUrl != null
                                  ? Image.network(
                                item.imageUrl!,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
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
                                  : null,
                              // ListTile의 onTap 제거
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
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
          onChanged: (query) {
            if (query.isNotEmpty) {
              _searchItems(query); // 검색어로 검색
            } else {
              setState(() {
                _searchedItems = []; // 검색어가 없으면 검색결과 초기화
              });
            }
          },
          onSubmitted: (query) {
            if (query.isNotEmpty) {
              _addRecentSearch(query); // 검색어 추가
              _searchItems(query); // 검색어로 검색
              _navigateToSearchResults(); // 결과 페이지로 이동
            }
          },
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async { // async로 변경
              if (_searchController.text.isNotEmpty) {
                _addRecentSearch(_searchController.text); // 검색어 추가
                await _searchItems(_searchController.text); // 검색어로 검색
                await _navigateToSearchResults(); // 결과 페이지로 이동
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
      body: _buildSearchArea(),
    );
  }
}
