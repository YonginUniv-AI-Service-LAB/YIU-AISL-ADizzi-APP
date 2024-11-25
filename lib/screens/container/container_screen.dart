import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_search_bar.dart';
import 'package:yiu_aisl_adizzi_app/widgets/floating_add_button.dart';
import 'package:yiu_aisl_adizzi_app/widgets/time_sort_seletor.dart';
import 'package:yiu_aisl_adizzi_app/widgets/container_list_view.dart';
import 'add_container.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({super.key});

  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  bool _isLatestSelected = true; // 초기값은 '최신등록순'임
  List<String> _items = []; // 리스트 데이터를 관리하는 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '금쪽이의 방',
          style: TextStyle(
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AnotherPage()),
              // );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // CustomSearchBar 사용
          CustomSearchBar(onTap: () {}),

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
            child: ContainerListView(items: _items),
          ),
        ],
      ),

      floatingActionButton: FloatingAddButton(
        onPressed: () async {
          // AddContainerPage로 이동 및 결과 받기
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContainerPage(
                onAdd: (String item) {
                  setState(() {
                    _items.add(item); // 리스트에 새 아이템 추가
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
