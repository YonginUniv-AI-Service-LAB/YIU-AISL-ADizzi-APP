import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/tree_provider.dart';
import 'package:yiu_aisl_adizzi_app/service/slot_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_search_bar.dart';
import 'package:yiu_aisl_adizzi_app/widgets/slot_list_view.dart';
import 'package:yiu_aisl_adizzi_app/widgets/time_sort_seletor.dart';
import 'package:yiu_aisl_adizzi_app/widgets/slot_add_button.dart'; // SlotAddButton 임포트
import 'package:yiu_aisl_adizzi_app/widgets/slot_add_dialog.dart';
// import 'package:yiu_aisl_adizzi_app/models/container.dart';

class SlotScreen extends StatefulWidget {
  final ContainerModel container; // 필드 이름 소문자로 변경

  const SlotScreen({super.key, required this.container});

  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  bool _isLatestSelected = true; // 초기값은 '최신등록순'
  List<SlotModel>? slots;
  List<ItemModel>? items;

  @override
  void initState() {
    Provider.of<TreeProvider>(context, listen: false).fetchTree(context);
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    String sortBy = _isLatestSelected ? 'recent' : 'old';
    SlotsResponse data = await getSlots(context, containerId: widget.container.containerId, sortBy: sortBy);
    slots = data.slots;
    items = data.items;
    setState(() {});
  }

  // 수납칸 추가 클릭 시 동작
  void _onAddShelf() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SlotAddDialog(
          onConfirm: (String shelfName) {
            // 입력된 수납칸 이름 처리
            print("입력된 수납칸 이름: $shelfName");
          },
        );
      },
    );
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
    final room = Provider.of<TreeProvider>(context).getRoomByContainerId(widget.container.containerId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.container.title!, // ContainerItem의 name 필드 사용
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${room?.title ?? '방 이름 조회 오류'} > ${widget.container.title}", // 동적 데이터 표시
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
          Expanded(
            child: slots == null
                ? Center(child: CircularProgressIndicator())
                : SlotListView(
              slots: slots!,
              loadData: _loadData,
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
