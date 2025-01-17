import 'package:flutter/material.dart';

import '../screens/user/my_page_screen.dart';
import '../screens/search/search_screen.dart';
import '../utils/model.dart';

class MainSearchBar extends StatelessWidget {
  final VoidCallback onTap;

  const MainSearchBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(214, 214, 214, 0.5),
            borderRadius: BorderRadius.circular(28),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  // 메뉴 버튼을 눌렀을 때 드로어 열기
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  child: Text(
                    '검색',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyPageScreen()),
                  );
                },
                icon: const Icon(Icons.account_circle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
