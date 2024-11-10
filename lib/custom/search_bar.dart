import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

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
                // 검색 아이콘 클릭 시 동작
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                // 사용자 아이콘 클릭 시 동작
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
        color: const Color.fromRGBO(214, 214, 214, 0.5),
        borderRadius: BorderRadius.circular(50),
      ),
      width: MediaQuery.of(context).size.width * 15,
      height:MediaQuery.of(context).size.width * 0.1,
      child: child,
    );
  }
}

class StyledInputBase extends StatelessWidget {
  const StyledInputBase({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: '검색어를 입력하세요',
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      ),
    );
  }
}
