import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/add_items.dart';
import 'package:yiu_aisl_adizzi_app/widgets/time_sort_seletor.dart';
import 'package:yiu_aisl_adizzi_app/widgets/floating_add_button.dart';
import 'package:yiu_aisl_adizzi_app/models/item_model.dart';

class ItemScreen extends StatefulWidget {
  // final String roomName;
  // final ContainerModel containerModel; // 필드 이름 소문자로 변경
  //
  // const SlotScreen({super.key, required this.containerModel, required this.roomName});
  //
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  bool isLatestSelected = true;  // 최신순 선택 상태 관리
  List<ItemModel> items = []; // 아이템 목록을 관리하는 리스트

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();  // 뒤로 가기
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
                  // "${widget.roomName} > ${widget.containerModel.title}", // 동적 데이터 표시
                  style: TextStyle(
                      color: Colors.grey[600], fontSize: 12,
                  ),
                ),
                // SizedBox(width: 23),  // 왼쪽 텍스트와 TimeSortSelector 사이 간격 생성
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

          Expanded(
            child: Container(
              color: Color(0xFFF0F0F0),  // 배경색 설정
              child: Center(
                child: Text(
                  '추가된 아이템이 없습니다.',  // 데이터가 없을 때 표시
                  style: TextStyle(color: Colors.grey),
                ),
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