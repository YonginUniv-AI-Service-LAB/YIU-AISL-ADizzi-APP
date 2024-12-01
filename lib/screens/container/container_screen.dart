import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/models/container_items.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_search_bar.dart';
import 'package:yiu_aisl_adizzi_app/widgets/floating_add_button.dart';
import 'package:yiu_aisl_adizzi_app/widgets/time_sort_seletor.dart';
import 'package:yiu_aisl_adizzi_app/widgets/container_list_view.dart';
import 'add_container.dart';

class ContainerScreen extends StatefulWidget {
  final String roomName; // 방 이름을 저장하는 변수

  const ContainerScreen({super.key, required this.roomName});

  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  bool _isLatestSelected = true; // 초기값은 '최신등록순'
  List<ContainerModel> _items = []; // 리스트 데이터를 관리하는 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.roomName, // 전달받은 방 이름을 사용하여 제목 설정
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {
              // main item 페이지로 이동
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // CustomSearchBar 사용
          CustomSearchBar(onTap: () {
            // 검색 기능 (필요 시 구현)
          }),

          // TimeSortSelector 위젯 사용
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

          // 리스트 위젯
          Expanded(
            child: ContainerListView(
              items: _items,
              roomName: widget.roomName, // roomName 전달
            ),
          ),
        ],
      ),

      // 추가 버튼
      floatingActionButton: FloatingAddButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContainerPage(
                roomName: widget.roomName, // roomName 전달
                onAdd: (ContainerModel item) {
                  setState(() {
                    _items.add(item); // 전달받은 ContainerItem을 리스트에 추가
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}