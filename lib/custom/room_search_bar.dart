import 'package:flutter/material.dart';

import '../screens/mypage/mypage.dart';
import '../screens/search/search_screen.dart';

class RoomCustomSearchBar extends StatelessWidget {
  final VoidCallback onTap;

  const RoomCustomSearchBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(



      onTap: onTap,

      child: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(214, 214, 214, 0.5),
            borderRadius: BorderRadius.circular(28),

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
                    MaterialPageRoute(builder: (context) => Search()),
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
