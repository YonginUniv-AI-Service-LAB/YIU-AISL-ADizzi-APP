import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/room_provider.dart';
import '../screens/container/container_screen.dart';
import 'custom_popup_menu.dart';

class CustomDivider extends StatelessWidget {
  final List<String> roomList;

  const CustomDivider({super.key, required this.roomList});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: roomList.length,
        itemBuilder: (context, index) {
          final room = roomList[index];
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    room,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                trailing: CustomPopupMenu(
                  onSelected: (int result) {
                    if (result == 0) {
                      // 수정 선택
                    } else if (result == 1) {
                      // 삭제 선택
                      roomProvider.removeRoom(room);
                    }
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContainerScreen(roomName: room),
                    ),
                  );
                },
              ),
              if (index != roomList.length - 1)
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
