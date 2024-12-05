import 'package:flutter/material.dart';

import 'package:yiu_aisl_adizzi_app/screens/user/change_pwd_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/item_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/user/login_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/user/my_page_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/search/search_detail_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/user/sign_up_screen.dart';
import '../models/container.dart';
import 'container/container_screen.dart';
import 'room/room_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/slot/slot_screen.dart';

import 'search/search_screen.dart';


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
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text('회원가입'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('로그인'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPageScreen()),
                );
              },
              child: Text('마이페이지'),
            ), ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>ChangePwdScreen()),
                );
              },
              child: Text('비밀번호 재설정'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoomScreen()),
                );
              },
              child: Text('Room 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContainerScreen(roomId: 1, roomName: "임시 방이름",)),
                );
              },
              child: Text('Container 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              child: Text('Search 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchDetailScreen()),
                );
              },
              child: Text('SearchDetail 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemScreen()),
                );
              },
              child: Text('Item 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SlotScreen(containerModel: ContainerModel(title:''), roomName: '')),
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