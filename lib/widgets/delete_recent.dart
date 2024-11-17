import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteRecent extends StatelessWidget {
  const DeleteRecent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '최근 검색어',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              // 전체 삭제 기능을 여기서 구현 가능
            },
            child: const Text(
              '전체 삭제',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
