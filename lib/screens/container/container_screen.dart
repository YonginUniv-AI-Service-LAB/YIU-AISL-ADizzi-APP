import 'package:flutter/material.dart';
import '../../widgets/floating_add_button.dart';
import '../../widgets/custom_search_bar.dart';
import 'add_container.dart';
import 'package:yiu_aisl_adizzi_app/widgets/time_sort_seletor.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({super.key});

  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  bool _isLatestSelected = true; // 초기값은 '최신등록순'임

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '금쪽이의 방',
          style: TextStyle(fontSize: 18),
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
           CustomSearchBar(onTap: () {  },

          ),

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

          const Expanded(
            child: Center(
              child: Text(
                '추가된 아이템이 없습니다.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingAddButton(
        onPressed: () {
          // add container 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContainerPage(onAdd: (item) {})),
          );
        },
      ),
    );
  }
}