import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/edit_item_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/item_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/slot/edit_slot_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/item_service.dart';
import 'package:yiu_aisl_adizzi_app/service/slot_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_popup_menu.dart';
import 'package:yiu_aisl_adizzi_app/widgets/move_tree.dart';
import 'package:yiu_aisl_adizzi_app/widgets/select_all_bar.dart';
import 'package:yiu_aisl_adizzi_app/widgets/item_row.dart';
import 'package:yiu_aisl_adizzi_app/widgets/item_card.dart';

class TempSlotListView extends StatefulWidget {
  final List<ItemModel> items;
  final List<SlotModel> slots;
  final Function(int) onItemTap;
  final Function(int, bool) onCheckboxChanged; // 체크박스 상태 변경 콜백 추가
  final bool isAllChecked; // 전체 선택 상태
  final Function(bool?) onSelectAllChanged; // 전체 선택 상태 변경 콜백
  final VoidCallback onDeleteSelected; // 선택된 항목 삭제 콜백 추가
  final Function loadData; // 선택된 항목 삭제 콜백 추가

  const TempSlotListView({
    Key? key,
    required this.items,
    required this.slots,
    required this.onItemTap,
    required this.onCheckboxChanged, // 콜백 추가
    required this.isAllChecked, // 전체 선택 상태 추가
    required this.onSelectAllChanged, // 전체 선택/해제 콜백 추가
    required this.onDeleteSelected, // 선택된 항목 삭제 콜백
    required this.loadData, // 선택된 항목 삭제 콜백
  }) : super(key: key);

  @override
  _TempSlotListViewState createState() => _TempSlotListViewState();
}

class _TempSlotListViewState extends State<TempSlotListView> {
  // 팝업 메뉴 동작 처리
  void _handlePopupMenuAction(int index, int action) async{
    if (action == 0) {
      // 수정 동작
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EditItemScreen(
                item: widget.items[index], // 선택된 항목 정보 전달
              ),
        ),
      ).then((_) {widget.loadData();});
    } else if (action == 1) {
      // 이동 동작
      // TODO: 이동할 위치 선택하는 트리 화면 보여주고 선택
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MoveTree(
                  slotIdFunction: (slotId) async{
                    try {
                      await moveItem(context, itemId: widget.items[index].itemId, slotId: slotId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('물건이 이동되었습니다.')),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('물건 이동 실패: $e')),
                      );
                    }
                  }
              ),
        ),
      ).then((_) {widget.loadData();});
      // print("아이템 이동 요청 itemId: ${widget.items[index].itemId}");
    } else if (action == 2) {
      // TODO: 삭제 동작 (삭제여부 1회 더 물어볼 UI(Dialog) 필요)
      await deleteItem(context, itemId: widget.items[index].itemId);
      widget.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty && widget.slots.isEmpty) {
      return const Center(
        child: Text(
          '등록된 물건 또는 수납칸이 없습니다.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Visibility(
            visible: !widget.items.isEmpty,
            child: SelectAllBar(
              isAllChecked: widget.isAllChecked,
              onSelectAllChanged: widget.onSelectAllChanged,
              onDeleteSelected: widget.onDeleteSelected,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length + widget.slots.length + 1, // 두 배열의 길이 합
              itemBuilder: (context, index) {
                // 두 배열의 인덱스를 구분
                if (index < widget.items.length) {
                  // items 배열의 경우
                  final item = widget.items[index];
                  return ItemRow(
                    item: item,
                    index: index,
                    onItemTap: (index) {
                      // 팝업 창 띄우기
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ItemCard(item: item), // 팝업 창으로 띄움
                            ),
                          );
                        },
                      );
                    },
                    onCheckboxChanged: widget.onCheckboxChanged,
                    onPopupMenuAction: _handlePopupMenuAction,
                  );
                }
                else if (index == widget.items.length) {
                  if (widget.items.isEmpty || widget.slots.isEmpty) {return SizedBox();}
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(height: 2,),
                  );
                }
                else {
                  // slots 배열의 경우
                  final slotIndex = index - widget.items.length - 1; // slots의 인덱스
                  final slot = widget.slots[slotIndex];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemScreen(
                            slot: slot,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 16.0),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Image.network(
                              slot.imageUrl!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // 로딩 완료 시 이미지 표시
                                } else {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[300], // 로딩 중 회색 박스
                                  );
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[300], // 로딩 실패 시 회색 박스
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              slot.title!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          CustomPopupMenu(
                            onSelected: (int result) async {
                              if (result == 0) {
                                // 수정
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditSlotScreen(slot: slot),
                                  ),
                                ).then((_) {
                                  widget.loadData();
                                });
                              } else if (result == 1) {
                                // 삭제
                                await deleteSlot(context, slotId: slot.slotId); // 삭제 기능 호출
                                widget.loadData();
                              }
                            },
                          ),
                          const SizedBox(width: 10.0),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}