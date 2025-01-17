import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/container/create_container_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/main/main_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/container_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_search_bar.dart';
import 'package:yiu_aisl_adizzi_app/widgets/floating_add_button.dart';
import 'package:yiu_aisl_adizzi_app/widgets/time_sort_seletor.dart';
import 'package:yiu_aisl_adizzi_app/widgets/container_list_view.dart';
import '../main/main_item_tab_view.dart';
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
  List<ContainerModel>? _containers; // 리스트 데이터를 관리하는 변수

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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(), // 수정할 아이템을 넘겨줌
                ),
                    (Route<dynamic> route) => false, // 모든 이전 화면을 제거
              );
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
              _isLatestSelected = true;
              _loadData();
            },
            onOldestTap: () {
              _isLatestSelected = false;
              _loadData();
            },
          ),

          // 리스트 위젯
          Expanded(
            child: _containers == null
                ? Center(child: CircularProgressIndicator())
                : ContainerListView(
                    containers: _containers!,
                    loadData: _loadData,
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
          ).then((_) {_loadData();});
        },
      ),
    );
  }
}