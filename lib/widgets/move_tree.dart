import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/tree_provider.dart';
import '../screens/main/main_folder_tree.dart';
import '../service/item_service.dart';
import '../utils/model.dart';

class MoveTree extends StatelessWidget {
  final ItemModel item; // 아이템을 전달받음

  const MoveTree({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("아이템 이동"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TreeProvider>(builder: (context, treeProvider, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: treeProvider.rooms.length,
            itemBuilder: (context, index) {
              final room = treeProvider.rooms[index];
              return FolderNode(
                folderName: room.title.toString(),
                children: room.containers.map<Widget>((container) {
                  return FileNode(
                    fileName: container.title.toString(),
                    children: container.slots.map<Widget>((slot) {
                      return ArticleNode(
                        articleName: slot.title.toString(),
                        onTap: () {
                          // 여기서 슬롯을 선택하면 아이템을 이동시키도록 함
                          _onItemSelected(context, slot.slotId);
                        },
                      );
                    }).toList(),
                  );
                }).toList(),
              );
            },
          );
        }),
      ),
    );
  }

  void _onItemSelected(BuildContext context, int slotId) {
    // 슬롯만 이동할 수 있음
    moveItem(
      context,
      itemId: item.itemId,
      slotId: slotId, // 슬롯으로만 이동
    ).then((_) {
      // 이동 성공 시 UI 피드백 또는 이전 화면으로 돌아가기
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이템이 이동되었습니다.')),
      );
      Navigator.pop(context); // 이전 화면으로 돌아가기
    }).catchError((e) {
      // 이동 실패 시 에러 메시지 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이템 이동 실패: $e')),
      );
    });
  }
}

class ArticleNode extends StatelessWidget {
  final String articleName;
  final VoidCallback onTap;

  const ArticleNode({Key? key, required this.articleName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.article),
      title: Text(articleName),
      onTap: onTap, // 아이템을 클릭하면 onTap 처리
    );
  }
}
