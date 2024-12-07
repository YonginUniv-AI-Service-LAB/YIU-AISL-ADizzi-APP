import 'package:flutter/material.dart';
import '../../service/item_service.dart';
import '../../service/search.dart';
import '../../utils/model.dart';
import '../../widgets/delete_recent.dart';  // 최근 검색어 삭제 위젯
import '../../widgets/search_list.dart';   // 검색어 리스트 표시 위젯

class SearchScreen extends StatefulWidget {
  final SlotModel slot;
  const SearchScreen({super.key, required this.slot});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isLatestSelected = true; // 최신순 선택 상태 관리
  List<ItemModel>? items;
  List<ItemModel> _searchedItems = [];  // 검색된 아이템 리스트
  bool _isLoading = false;  // 로딩 상태를 관리

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // 검색어를 입력하면 getSearch 호출
  void _searchItems(String query) async {
    setState(() {
      _isLoading = true;
      _searchedItems = [];  // 검색 결과 초기화
    });

    try {
      String sortBy = isLatestSelected ? 'recent' : 'old';
      List<ItemModel> items = await getItems(context, slotId: widget.slot.slotId, sortBy: sortBy);

      // 아이템들 중에서 title에 query가 포함된 항목만 필터링
      List<ItemModel> searchResults = items.where((item) {
        return item.title != null && item.title!.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        _searchedItems = searchResults;  // 검색 결과 업데이트
        _isLoading = false;  // 로딩 완료
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
              _searchItems(query);  // 검색어로 검색
            } else {
              setState(() {
                _searchedItems = [];  // 검색어가 없으면 검색결과 초기화
              });
            }
          },
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                _searchItems(_searchController.text);  // 검색어로 검색
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
          // 검색어가 없고 최근 검색어가 있을 때 DeleteRecent 컴포넌트 표시
          if (_searchController.text.isEmpty)
            const DeleteRecent(),

          // 로딩 중에는 CircularProgressIndicator 표시
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),

          // 검색된 아이템 목록을 표시
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: _searchedItems.length,
                itemBuilder: (context, index) {
                  ItemModel item = _searchedItems[index];
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {


                      },

                      child: ListTile(
                        title: Text(item.title!),
                        leading: item.imageUrl != null
                            ? Image.network(item.imageUrl!)
                            : null,
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        trailing: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchedItems.removeAt(index);  // 해당 아이템 삭제
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )


        ],
      ),
    );
  }
}
