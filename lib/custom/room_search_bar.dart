import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/searchDetail/search_detail_screen.dart';

import '../screens/mypage/mypage.dart';

class RoomCustomSearchBar extends StatelessWidget {
  final VoidCallback onTap;

  const RoomCustomSearchBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Padding(
        padding: const EdgeInsets.all(6.0),

        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(214, 214, 214, 0.5),
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.menu),
              ),
              const Expanded(
                child: Text(
                  '검색',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SearchDetail()),
                  );
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyPage()),
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
