import 'package:flutter/material.dart';

class ContainerListView extends StatelessWidget {
  final List<String> items; // 리스트 데이터
  const ContainerListView({required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          '추가된 아이템이 없습니다.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index], style: TextStyle(fontSize: 15),),
          leading: const Icon(Icons.storage),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // 삭제 수정 버튼
            },
          ),
        );
      },
    );
  }
}
