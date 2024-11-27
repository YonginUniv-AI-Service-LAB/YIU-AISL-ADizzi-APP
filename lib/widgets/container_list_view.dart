import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/models/container_items.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_popup_menu.dart';

class ContainerListView extends StatelessWidget {
  final List<ContainerItem> items;
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0), // 항목 사이 간격
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // 텍스트와 이미지 중앙 정렬
            children: [
              const SizedBox(width: 16.0), // 왼쪽 여백

              // 이미지 위젯
              item.image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(2), // 모서리 둥글게
                child: Image.file(
                  item.image!,
                  width: 80, // 이미지 가로 크기
                  height: 80, // 이미지 세로 크기
                  fit: BoxFit.cover, // 이미지를 꽉 채우기
                ),
              )
                  : const Icon(Icons.storage, size: 80),

              const SizedBox(width: 16.0), // 이미지와 텍스트 사이 간격

              // 텍스트
              Expanded(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14, // 글자 크기
                    fontWeight: FontWeight.w400, // 글자 두께
                  ),
                ),
              ),

              // 점 세 개 메뉴 (팝업 메뉴)
              CustomPopupMenu(
                onSelected: (int result) {
                  if (result == 0) {
                    // 수정 선택
                  } else if (result == 1) {
                    // 삭제 선택
                  }
                },
              ),
              const SizedBox(width: 10.0), // 오른쪽 여백 추가
            ],
          ),
        );
      },
    );
  }
}