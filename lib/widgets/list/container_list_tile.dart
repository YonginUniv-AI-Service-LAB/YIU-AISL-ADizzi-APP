import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/container/edit_container_screen.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_popup_menu.dart';

class ContainerListTile extends StatelessWidget {
  final ContainerModel container;

  const ContainerListTile({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // SlotScreen으로 이동 시 roomName도 전달
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => SlotScreen(
        //       containerModel: container,
        //     ),
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 16.0),
            // item.imageId != null
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.network(
                  container.imageUrl!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover
              ),
              // child: Image.file(
              //   item.imageId! as File,
              //   width: 80,
              //   height: 80,
              //   fit: BoxFit.cover,
              // ),
            ),

            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                container.title!,
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
                  final updatedItem = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditContainerScreen(
                        initialItem: item,
                        roomName: widget.roomName,
                        onAdd: (updatedItem) {
                          setState(() {
                            widget.items[index] = updatedItem;
                          });
                        },
                      ),
                    ),
                  );
                } else if (result == 1) {
                  // 삭제
                  _deleteItem(index); // 삭제 기능 호출
                }
              },
            ),
            const SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }
}
