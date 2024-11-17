import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_search_bar.dart';
import 'package:yiu_aisl_adizzi_app/widgets/time_sort_seletor.dart';
import 'package:yiu_aisl_adizzi_app/widgets/slot_add_button.dart'; // SlotAddButton 임포트

class SlotScreen extends StatefulWidget {
  const SlotScreen({super.key});

  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  bool _isLatestSelected = true; // 초기값은 '최신등록순'

  // 수납칸 추가 클릭 시 동작
  void _onAddShelf() {
    setState(() {
      // 수납칸 추가 로직
      print("수납칸 추가 클릭됨");
    });
  }

  // 물건 추가 클릭 시 동작
  void _onAddItem() {
    setState(() {
      // 물건 추가 로직
      print("물건 추가 클릭됨");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '옷장',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {
              // main item 페이지로 이동
            },
          )
        ],
      ),
      body: Column(
        children: [
          // CustomSearchBar 사용
          CustomSearchBar(
            onTap: () {
              // 검색창 동작
            },
          ),
          // 정렬 섹션
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "금쪽이의 방 > 옷장",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                TimeSortSelector(
                  isLatestSelected: _isLatestSelected,
                  onLatestTap: () {
                    setState(() {
                      _isLatestSelected = true;
                    });
                  },
                  onOldestTap: () {
                    setState(() {
                      _isLatestSelected = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // 플로팅 버튼과 추가 버튼들
      floatingActionButton: SlotAddButton(
        onAddShelf: _onAddShelf,
        onAddItem: _onAddItem,
      ),
    );
  }
}
