import 'package:flutter/material.dart';
import '../../widgets/delete_recent.dart';
import '../../widgets/search_list.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  List<String> searchData = [
    '용용인형',
    '쉽게 배우는 파이썬',
    '미분적분학',
    'lg 그램 2023',
    '건전지',
    '목도리',
    '모자',
    '태권도 도복',
    '틴트',
    '목도리',
    '레러팟',
    '커피',
    '안주연',
    '카메라',
    '모니터'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          scrolledUnderElevation: 0, // 스크롤 할 때 앱바 색상 변경되지 않도록
          backgroundColor: Colors.white,
          title: const TextField(
            autofocus: true, // 화면이 열리면 자동으로 키보드가 올라오게 설정
            decoration: InputDecoration(
              hintText: '검색어를 입력해주세요',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.black54, fontSize: 17),
            ),
            style: TextStyle(color: Colors.black87),
          ),
          titleSpacing: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // 검색 기능 처리
              },
            ),
          ],
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFF5DDA6F),
          )
        )

      ),

      body: Column(

        children: [
          const DeleteRecent(),
          Expanded(
            child: SearchList(searchData: searchData),
          ),
        ],
      ),
    );
  }
}
