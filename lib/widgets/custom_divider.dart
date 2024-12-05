import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/service/room_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/add_dialog.dart';
import '../provider/room_provider.dart';
import '../screens/container/container_screen.dart';
import 'custom_popup_menu.dart';

class CustomDivider extends StatefulWidget {
  final List<RoomModel> roomList; // roomList를 외부에서 받아옵니다.


  // 생성자에서 roomList를 받도록 수정
  CustomDivider({required this.roomList});
  @override
  State<CustomDivider> createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  List<RoomModel> _rooms = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async{
    _rooms = await getRooms(context, sortBy: 'recent');
    setState(() {});
  }

 // 생성자에서 roomList를 필수로 받습니다.
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _rooms.length,
        itemBuilder: (context, index) {
          final room = _rooms[index]; // Room 객체를 가져옵니다.
          final roomId = room.roomId; // roomId는 Room 객체의 roomId 속성으로 가져옵니다.
          print('Room title: ${room.title}, Room ID: ${room.roomId}');
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child:
                    Text(
                      room.title!, // room.title로 제목을 표시
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                ),
                trailing: CustomPopupMenu(
                  onSelected: (int result) async {
                    if (result == 0) {
                      // 수정 선택 시 다이얼로그 표시
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddDialog(
                            isEdit: true,
                            initialTitle: room.title,
                            roomId: room.roomId,
                          );
                        },
                      ).then((_) {
                        _loadData();
                      });
                    }  else if (result == 1) {
                      // 삭제 선택
                      await deleteRoom(context, roomId: roomId);
                      _loadData();
                    }
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContainerScreen(roomName: room.title!, roomId: roomId,),
                    ),
                  );
                },
              ),
              if (index != widget.roomList.length - 1)
                const Divider(
                  color: Color(0x80D6D6D6),
                  thickness: 1.5,
                ),
            ],
          );
        },
      ),
    );
  }
}
