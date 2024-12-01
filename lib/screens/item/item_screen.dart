import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/add_items.dart';
import 'package:yiu_aisl_adizzi_app/widgets/time_sort_seletor.dart';
import 'package:yiu_aisl_adizzi_app/widgets/floating_add_button.dart';
import 'package:yiu_aisl_adizzi_app/models/item_model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/item_list_view.dart';

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  bool isLatestSelected = true; // 최신순 선택 상태 관리
  List<ItemModel> items = []; // 아이템 목록을 관리하는 리스트

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로 가기
          },
        ),
        title: Text(
          '서랍1',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view),
            onPressed: () {
              // 그리드 아이콘 동작 추가
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '금쪽이의 밤 > 옷장 > 서랍1',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                TimeSortSelector(
                  isLatestSelected: isLatestSelected,
                  onLatestTap: () {
                    setState(() {
                      isLatestSelected = true;
                    });
                  },
                  onOldestTap: () {
                    setState(() {
                      isLatestSelected = false;
                    });
                  },
                ),
              ],
            ),
          ),

          // 아이템 리스트를 감싸는 Container 추가
          Expanded(
            child: Container(
              color: Color(0xFFF0F0F0), // 배경 색상 설정
              child: ItemListView(
                items: items,
                onItemTap: (index) {
                  print('아이템 ${items[index].title} 클릭됨'); // 클릭 이벤트 처리
                },
                onCheckboxChanged: (index, isChecked) {
                  setState(() {
                    items[index].isChecked = isChecked;
                  });
                },
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingAddButton(
        onPressed: () async {
          final newItem = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemsPage()),
          );

          if (newItem != null) {
            setState(() {
              items.add(newItem);  // 새로 추가된 아이템 저장
            });
          }
        },
      ),
    );
  }
}
