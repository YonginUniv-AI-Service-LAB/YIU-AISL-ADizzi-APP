import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/tree_provider.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/add_item_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/item_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/time_sort_seletor.dart';
import 'package:yiu_aisl_adizzi_app/widgets/floating_add_button.dart';
import 'package:yiu_aisl_adizzi_app/widgets/item_list_view.dart';

class ItemScreen extends StatefulWidget {
  final SlotModel slot;

  const ItemScreen({super.key, required this.slot});

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  bool isLatestSelected = true; // 최신순 선택 상태 관리
  List<ItemModel>? items; // 아이템 목록을 관리하는 리스트
  ItemModel? selectedItem; // 수정할 아이템을 저장할 변수

  @override
  void initState() {
    _loadData();
    super.initState();
    Provider.of<TreeProvider>(context, listen: false).fetchTree(context);
  }

  Future<void> _loadData() async{
    // sortBy 매핑
    String sortBy = isLatestSelected ? 'recent' : 'old';
    items = await getItems(context, slotId: widget.slot.slotId, sortBy: sortBy);
    setState(() {});
  }

  // 전체 선택 상태 계산
  bool get isAllChecked {
    return items!.every((item) => item.isChecked); // 모든 아이템이 체크되었는지 확인
  }

  // 전체 선택/해제 처리
  void _toggleSelectAll(bool? isChecked) {
    setState(() {
      for (var item in items!) {
        item.isChecked = isChecked ?? false;
      }
    });
  }

  // 선택 삭제 처리
  void _deleteSelectedItems() async{
    for (var item in items!) {
      if(item.isChecked) {
        await deleteItem(context, itemId: item.itemId);
      }
    }
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final room = Provider.of<TreeProvider>(context).getRoomBySlotId(widget.slot.slotId);
    final container = Provider.of<TreeProvider>(context).getContainerBySlotId(widget.slot.slotId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로 가기
          },
        ),
        title: Text(
          widget.slot.title ?? "수납칸 이름 조회 오류",
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
                  '${room?.title ?? '방 이름 조회 오류'} > ${container?.title ?? '수납장 이름 조회 오류'} > ${widget.slot.title ?? '수납칸 이름 조회 오류'}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                TimeSortSelector(
                  isLatestSelected: isLatestSelected,
                  onLatestTap: () {
                    isLatestSelected = true;
                    _loadData();
                  },
                  onOldestTap: () {
                    isLatestSelected = false;
                    _loadData();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFF0F0F0), // 배경 색상 설정
              child: items == null
                  ? Center(child: CircularProgressIndicator())
                  : ItemListView(
                      items: items!,
                      onItemTap: (index) {
                        setState(() {
                          selectedItem = items![index]; // 선택된 아이템을 selectedItem에 저장
                        });
                        print('아이템 ${items![index].title} 클릭됨'); // 클릭 이벤트 처리
                      },
                      onCheckboxChanged: (index, isChecked) {
                        setState(() {
                          items![index].isChecked = isChecked;
                        });
                      },
                      isAllChecked: isAllChecked, // 전체 선택 상태 전달
                      onSelectAllChanged: _toggleSelectAll, // 전체 선택/해제 처리
                      onDeleteSelected: _deleteSelectedItems, // 선택 삭제 처리
                      loadData: _loadData,
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemScreen(slotId: widget.slot.slotId,), // 수정할 아이템을 넘겨줌
            ),
          ).then((_) {_loadData();});
        },
      ),
    );
  }
}