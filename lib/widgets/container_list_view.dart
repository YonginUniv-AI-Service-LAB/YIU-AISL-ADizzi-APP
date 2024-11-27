import 'package:flutter/material.dart';
import 'dart:io';
import 'package:yiu_aisl_adizzi_app/models/container_items.dart';

class ContainerListView extends StatelessWidget {
  final List<ContainerItem> items; // 리스트 데이터
  const ContainerListView({required this.items, Key? key}) : super(key: key);

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
        final item = items[index];
        return ListTile(
          leading: item.image != null
              ? Image.file(
            item.image!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          )
              : const Icon(Icons.storage, size: 50),
          title: Text(
            item.name,
            style: const TextStyle(fontSize: 15),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // 삭제 수정 버튼 로직 추가 가능
            },
          ),
        );
      },
    );
  }
}

