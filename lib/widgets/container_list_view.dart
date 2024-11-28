import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/models/container_items.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_popup_menu.dart';
import 'package:yiu_aisl_adizzi_app/screens/container/add_container.dart';

class ContainerListView extends StatefulWidget {
  final List<ContainerItem> items;

  const ContainerListView({required this.items, Key? key}) : super(key: key);

  @override
  _ContainerListViewState createState() => _ContainerListViewState();
}

class _ContainerListViewState extends State<ContainerListView> {
  void _deleteItem(int index) {
    setState(() {
      widget.items.removeAt(index); // 리스트에서 항목 제거
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const Center(
        child: Text(
          '추가된 아이템이 없습니다.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 16.0),
              item.image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.file(
                  item.image!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              )
                  : const Icon(Icons.storage, size: 80),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  item.name,
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
                        builder: (context) => AddContainerPage(
                          initialItem: item,
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
        );
      },
    );
  }
}