import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/changePwd/change_pwd_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/item_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/login/login_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/mypage/mypage.dart';
import 'package:yiu_aisl_adizzi_app/screens/search/search_detail_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/signUp/signUp_screen.dart';
import '../container/container_screen.dart';
import '../room/room_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/slot/slot_screen.dart';

import '../search/search_screen.dart';


class TempStartScreen extends StatefulWidget {
  const TempStartScreen({super.key});

  @override
  State<TempStartScreen> createState() => _TempStartScreenState();
}

class _TempStartScreenState extends State<TempStartScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page1'),
      ),
      body: Center(
        child: Wrap(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text('회원가입'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text('로그인'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPage()),
                );
              },
              child: Text('마이페이지'),
            ), ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>ChangePwd()),
                );
              },
              child: Text('비밀번호 재설정'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Room()),
                );
              },
              child: Text('Room 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContainerScreen()),
                );
              },
              child: Text('Container 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Search()),
                );
              },
              child: Text('Search 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchDetail()),
                );
              },
              child: Text('SearchDetail 페이지'),
            ),ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Item()),
                );
              },
              child: Text('Item 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SlotScreen()),
                );
              },
              child: Text('Slot 페이지'),
            ),
          ],
        ),
      ),
    );
  }
}