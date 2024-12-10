import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/container/container_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/room_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/add_dialog.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_popup_menu.dart';

class MainRoomTabView extends StatelessWidget {
  final List<RoomModel> rooms; // rooms 리스트
  final Function loadData; // 데이터 로드 함수

  const MainRoomTabView({
    required this.rooms,
    required this.loadData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10),
      child: rooms.isEmpty
          ? Center(
              child: Text(
                '등록된 방이 없습니다.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index]; // Room 객체를 가져옵니다.
                final roomId = room.roomId; // roomId는 Room 객체의 roomId 속성으로 가져옵니다.
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
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
                              loadData(); // 데이터 로드
                            });
                          } else if (result == 1) {
                            // 삭제 선택
                            await deleteRoom(context, roomId: roomId);
                            loadData(); // 데이터 로드
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
                    if (index != rooms.length - 1)
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
