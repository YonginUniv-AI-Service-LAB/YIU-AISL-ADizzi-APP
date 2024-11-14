import 'package:flutter/material.dart';

import '../../widgets/searchList.dart';

class SearchDetail extends StatelessWidget {
   List<String> searchData = [
    '용용인형',
    '쉽게 배우는 파이썬',
    '미분적분학',
    'lg 그램 2023',
    '태권도 도복',
  ];

   SearchDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const SearchContainer(),
          const DeleteRecentContainer(),
          Expanded(
            child: SearchList(searchData: searchData),
          ),
        ],
      ),
    );
  }
}

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 70,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF5DDA6F)),
        ),
      ),
      child: const Row(
        children: [
          Icon(Icons.arrow_back),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '검색어',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black12,
              ),
            ),
          ),
          Icon(Icons.search),
        ],
      ),
    );
  }
}

class DeleteRecentContainer extends StatelessWidget {
  const DeleteRecentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '최근 검색어',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            '전체 삭제',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

