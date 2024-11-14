import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/searchDetail/search_detail.dart';

import '../screens/mypage/mypage.dart';

class RoomCustomSearchBar extends StatelessWidget {
  const RoomCustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return WholeContainer(
      child: SearchBarContainer(

        child: Row(
          children: [
            IconButton(
              onPressed: () {
                // 메뉴 아이콘 클릭 시 동작
              },
              icon: const Icon(Icons.menu),
            ),
            const Expanded(
              child: StyledInputBase(),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (contest) =>  SearchDetail()),
                );
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (contest) =>  MyPage()),
                );
              },
              icon: const Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
    );
  }
}

class WholeContainer extends StatelessWidget {
  final Widget child;

  const WholeContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}

class SearchBarContainer extends StatelessWidget {
  final Widget child;

  const SearchBarContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x80D6D6D6),
        borderRadius: BorderRadius.circular(50),
      ),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.width * 0.14,
      child: child,
    );
  }
}

class StyledInputBase extends StatelessWidget {
  const StyledInputBase({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      style: TextStyle(
        fontSize: 15.0,
      ),
      decoration: InputDecoration(
        hintText: '검색어를 입력하세요.',
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.0), // 패딩 조정
      ),
    );
  }
}
