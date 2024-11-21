import 'package:flutter/material.dart';
import '../../widgets/delete_recent.dart';
import '../../widgets/searchList.dart';

class Search extends StatelessWidget {
  Search({super.key});

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
        backgroundColor: Colors.white,
        title: const Text('검색어를 입력해주세요'),
        titleTextStyle: const TextStyle(color: Colors.black54,fontSize: 17),
          titleSpacing: 0,
          actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
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
