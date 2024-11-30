import 'package:flutter/material.dart';

class NameHeaderWidget extends StatelessWidget {
  final String roomName;
  final String? containerName; // 컨테이너 이름은 선택적으로 표시

  const NameHeaderWidget({required this.roomName, this.containerName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            containerName != null
                ? "$roomName > $containerName"
                : roomName, // 컨테이너 이름이 없으면 방 이름만 표시
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
