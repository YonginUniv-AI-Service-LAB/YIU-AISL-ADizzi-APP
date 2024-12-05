import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/container/create_container_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/container_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_search_bar.dart';
import 'package:yiu_aisl_adizzi_app/widgets/floating_add_button.dart';
import 'package:yiu_aisl_adizzi_app/widgets/time_sort_seletor.dart';
import 'package:yiu_aisl_adizzi_app/widgets/container_list_view.dart';
import 'edit_container_screen.dart';

class ContainerScreen extends StatefulWidget {
  final String roomName; // 방 이름을 저장하는 변수
  final int roomId;

  const ContainerScreen({super.key, required this.roomName, required this.roomId});

  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  bool _isLatestSelected = true; // 초기값은 '최신등록순'
  List<ContainerModel> _containers = []; // 리스트 데이터를 관리하는 변수

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async{
    // sortBy 매핑
    String sortBy = _isLatestSelected ? 'recent' : 'old';
    _containers = await getContainers(context, roomId: widget.roomId, sortBy: sortBy);
    setState(() {});
  }

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
              items: _containers,
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
              builder: (context) => CreateContainerScreen(roomId: widget.roomId,),
            ),
          );
        },
      ),
    );
  }
}