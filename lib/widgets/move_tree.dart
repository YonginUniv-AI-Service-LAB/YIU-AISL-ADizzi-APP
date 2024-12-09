import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/screens/container/container_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/item_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/slot/slot_screen.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import '../../provider/tree_provider.dart';
import '../service/item_service.dart';

class MoveTree extends StatelessWidget {
  final Function(int) slotIdFunction;
  final bool? isCreate;
  const MoveTree({super.key, required this.slotIdFunction, this.isCreate = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("아이템 이동")
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
                      slotIdFunction: slotIdFunction,
                      container: container, // Container를 파일로 표현
                      children: container.slots.map<Widget>((slot) {
                        return SlotNode(
                          slotIdFunction: slotIdFunction,
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
  // void _onSlotSelected(BuildContext context, int slotId, int itemId) async{
  //   // 슬롯만 이동할 수 있음
  //   moveItem(
  //     context,
  //     itemId: itemId,
  //     slotId: slotId,
  //
  //
  //   ).then((_) {
  //     // 이동 성공 시 UI 피드백 또는 이전 화면으로 돌아가기
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('아이템이 이동되었습니다.')),
  //     );
  //     Navigator.pop(context); // 이전 화면으로 돌아가기
  //   }).catchError((e) {
  //     // 이동 실패 시 에러 메시지 처리
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('아이템 이동 실패: $e')),
  //     );
  //   });
  // }
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
  final Function(int) slotIdFunction;

  const ContainerNode({Key? key, required this.container, this.children = const [], required this.slotIdFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      showTrailingIcon: children.length == 0 ? false : true,
      title: Row(
        children: [
          IconButton(icon: Icon(Icons.insert_drive_file), onPressed: (){slotIdFunction(container.slotId!);}),
          Expanded(child: TextButton(child: Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: Text(
              container.title!,
              textAlign: TextAlign.left, // 텍스트 정렬
            ),
          ), onPressed: (){slotIdFunction(container.slotId!);},)),
        ],
      ),
      children: children,
    );
  }
}

class SlotNode extends StatelessWidget {
  final SlotModel slot;
  final Function(int) slotIdFunction;

  const SlotNode({Key? key, required this.slot, required this.slotIdFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      showTrailingIcon: false,
      title: Row(
        children: [
          SizedBox(width: 15,),
          IconButton(icon: Icon(Icons.article), onPressed: (){slotIdFunction(slot.slotId);},),
          Expanded(child: TextButton(child: Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: Text(
              slot.title!,
              textAlign: TextAlign.left, // 텍스트 정렬
            ),
          ), onPressed: (){slotIdFunction(slot.slotId);},)),
        ],
      ),
    );
  }
}


