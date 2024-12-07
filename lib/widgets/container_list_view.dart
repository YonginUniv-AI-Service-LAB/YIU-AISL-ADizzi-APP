import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/slot/slot_screen.dart'; // Slot 화면 경로
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_popup_menu.dart';
import 'package:yiu_aisl_adizzi_app/screens/container/edit_container_screen.dart';

class ContainerListView extends StatefulWidget {
  final List<ContainerModel> containers;
  final Function loadData;

  const ContainerListView({
    required this.containers,
    required this.loadData,
    Key? key
  }) : super(key: key);

  @override
  _ContainerListViewState createState() => _ContainerListViewState();
}

class _ContainerListViewState extends State<ContainerListView> {
  void _deleteItem(int index) {
    setState(() {
      widget.containers.removeAt(index); // 리스트에서 항목 제거
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.containers.isEmpty) {
      return const Center(
        child: Text(
          '추가된 수납장이 없습니다.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.containers.length,
      itemBuilder: (context, index) {
        final container = widget.containers[index];
        return GestureDetector(
          onTap: () {
            // SlotScreen으로 이동 시 roomName도 전달
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SlotScreen(
                  container: container,
                ),
              ),
            );
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
                    fit: BoxFit.cover,
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
                  onSelected: (int result) {
                    if (result == 0) {
                      // 수정
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditContainerScreen(container: container,),
                        ),
                      ).then((_) {widget.loadData();});
                    } else if (result == 1) {
                      // 삭제
                      _deleteItem(index); // 삭제 기능 호출
                      widget.loadData();
                    }
                  },
                ),
                const SizedBox(width: 10.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
