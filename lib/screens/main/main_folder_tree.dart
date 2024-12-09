import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/screens/container/container_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/item_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/slot/slot_screen.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import '../../provider/tree_provider.dart';

class MainFolderTree extends StatelessWidget {
  const MainFolderTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TreeProvider>( // TreeProvider를 Consumer로 감싸서 상태 관리
          builder: (context, treeProvider, child) {
            if(treeProvider.rooms.isEmpty) {
              return Center(child: Text(
                '등록된 방이 없습니다.',
                style: TextStyle(color: Colors.grey),
              ),);
            }
            return ListView.builder(
              shrinkWrap: true, // 내부 스크롤뷰에 맞게 크기 조정
              itemCount: treeProvider.rooms.length,
              itemBuilder: (context, index) {
                final room = treeProvider.rooms[index];
                return RoomNode(
                  title: room.title!, // Room의 이름을 폴더로 사용
                  children: room.containers.map<Widget>((container) {
                    return ContainerNode(
                      container: container, // Container를 파일로 표현
                      children: container.slots.map<Widget>((slot) {
                        return SlotNode(
                          slot: slot, // Slot을 아티클로 표현
                        );
                      }).toList(),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class RoomNode extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const RoomNode({Key? key, required this.title, this.children = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      showTrailingIcon: children.length == 0 ? false : true,
      leading: const Icon(Icons.folder),
      title: Text(title),
      children: children, // 자식 항목들을 하위로 표시
    );
  }
}

class ContainerNode extends StatelessWidget {
  final ContainerModel container;
  final List<Widget> children;

  const ContainerNode({Key? key, required this.container, this.children = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      showTrailingIcon: children.length == 0 ? false : true,
      title: Row(
        children: [
          IconButton(icon: Icon(Icons.insert_drive_file), onPressed: (){
            Navigator.pop(
              context
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SlotScreen(container: container,)),
            );
          },),
          Expanded(child: TextButton(child: Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: Text(
              container.title!,
              textAlign: TextAlign.left, // 텍스트 정렬
            ),
          ), onPressed: (){
            Navigator.pop(
                context
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SlotScreen(container: container,)),
            );
          },)),
        ],
      ),
      children: children,
    );
  }
}

class SlotNode extends StatelessWidget {
  final SlotModel slot;

  const SlotNode({Key? key, required this.slot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      showTrailingIcon: false,
      title: Row(
        children: [
          SizedBox(width: 15,),
          IconButton(icon: Icon(Icons.article), onPressed: (){
            Navigator.pop(
                context
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemScreen(slot: slot,)),
            );
          },),
          Expanded(child: TextButton(child: Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: Text(
              slot.title!,
              textAlign: TextAlign.left, // 텍스트 정렬
            ),
          ), onPressed: (){
            Navigator.pop(
                context
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemScreen(slot: slot,)),
            );
          },)),
        ],
      ),
    );
  }
}
