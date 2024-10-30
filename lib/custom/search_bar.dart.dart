import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(214, 214, 214, 0.5), // 배경 색상
        borderRadius: BorderRadius.circular(50), // 테두리 둥글게
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // 메뉴 아이콘 클릭 시 동작
            },
            icon: const Icon(Icons.menu, color: Color(0xFF49454F)), // 아이콘 색상
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Google Maps",
                border: InputBorder.none, // 테두리 없음
                contentPadding: EdgeInsets.symmetric(vertical: 10), // 수직 패딩
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // 검색 아이콘 클릭 시 동작
            },
            icon: const Icon(Icons.search, color: Color(0xFF49454F)), // 아이콘 색상
          ),
          const VerticalDivider(
            width: 1,
            thickness: 2,
            color: Colors.grey,
            // 수직 구분선 스타일 설정
          ),
          IconButton(
            onPressed: () {
              // 사용자 아이콘 클릭 시 동작
            },
            icon: const Icon(Icons.account_circle_outlined, color: Color(0xFF49454F)), // 아이콘 색상
          ),
        ],
      ),
    );
  }
}
