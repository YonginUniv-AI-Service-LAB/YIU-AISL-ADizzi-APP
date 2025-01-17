import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
// import 'package:yiu_aisl_adizzi_app/models/item_model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_popup_menu.dart';
import 'package:yiu_aisl_adizzi_app/widgets/item_popup_menu.dart';

class ItemRow extends StatelessWidget {
  final ItemModel item;
  final int index;
  final Function(int, bool) onCheckboxChanged; // 올바른 타입 유지
  final Function(int) onItemTap;
  final Function(int, int) onPopupMenuAction;

  const ItemRow({
    Key? key,
    required this.item,
    required this.index,
    required this.onItemTap,
    required this.onCheckboxChanged,
    required this.onPopupMenuAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onItemTap(index), // 아이템 클릭 이벤트
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 체크박스
            Checkbox(
              value: item.isChecked,
              onChanged: (bool? value) {
                if (value != null) {
                  onCheckboxChanged(index, value); // 클로저로 감싸서 index 전달
                }
              },
              activeColor: const Color(0xFF5DDA6F),
              side: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            // 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.network(
                item.imageUrl!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    // 로딩 완료 시 이미지 표시
                    return child;
                  } else {
                    // 로딩 중 회색 박스 표시
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  // 로딩 실패 시 대체 UI
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                  );
                },
              ),
            ),
            const SizedBox(width: 16), // 간격
            // 제목
            Expanded(
              child: Text(
                item.title!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // 팝업 메뉴
            ItemPopupMenu(
              onSelected: (value) {
                onPopupMenuAction(index, value);
              },
            ),
          ],
        ),
      ),
    );
  }
}