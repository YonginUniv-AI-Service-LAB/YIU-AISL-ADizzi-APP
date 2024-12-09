import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/tree_provider.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/add_item_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/slot/create_slot_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/slot_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_search_bar.dart';
import 'package:yiu_aisl_adizzi_app/widgets/slot_list_view.dart';
import 'package:yiu_aisl_adizzi_app/widgets/temp_slot_list_view.dart';
import 'package:yiu_aisl_adizzi_app/widgets/time_sort_seletor.dart';
import 'package:yiu_aisl_adizzi_app/widgets/slot_add_button.dart'; // SlotAddButton 임포트
import 'package:yiu_aisl_adizzi_app/widgets/slot_add_dialog.dart';


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
  ItemModel? selectedItem; // 수정할 아이템을 저장할 변수

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateSlotScreen(container: widget.container),
      ),
    ).then((_) {_loadData();});
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return SlotAddDialog(
    //       onConfirm: (String shelfName) {
    //         // 입력된 수납칸 이름 처리
    //         print("입력된 수납칸 이름: $shelfName");
    //       },
    //     );
    //   },
    // );
  }

  // 물건 추가 클릭 시 동작
  void _onAddItem() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddItemScreen(slotId: widget.container.slotId!,),
        )).then((_) {_loadData();});
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
        // await deleteItem(context, itemId: item.itemId);
        print("delete itemId : ${item.itemId}");
      }
    }
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final path = Provider.of<TreeProvider>(context).getPathByContainerId(widget.container.containerId);
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
                  path, // 동적 데이터 표시
                  style: TextStyle(color: Colors.grey[600]),
                ),
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
              ],
            ),
          ),
          Expanded(
            child: items == null && slots == null
                ? Center(child: CircularProgressIndicator())
                : TempSlotListView(
              items: items!,
              slots: slots!,
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