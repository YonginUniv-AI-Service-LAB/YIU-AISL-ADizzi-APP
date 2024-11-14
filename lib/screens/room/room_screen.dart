import 'package:flutter/material.dart';


import '../../custom/search_bar.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/fa_button.dart.dart';
import '../../widgets/image_list_view.dart';

class Room extends StatefulWidget {
  const Room({super.key});

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> with SingleTickerProviderStateMixin {
  late TabController _tabController; // TabController

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 두 개의 탭


  }

  @override
  void dispose() {
    _tabController.dispose(); // TabController 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const CustomSearchBar(),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0, // AppBar의 그림자 없애기
        bottom: TabBar(
          controller: _tabController, // TabController 추가
          indicatorColor: const Color(0xFF5DDA6F), // 선택된 탭의 색상
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: 'Room'),
            Tab(text: 'Item'),
          ],
          labelColor: const Color(0xFF5DDA6F), // 선택된 탭의 텍스트 색상
          unselectedLabelColor: Colors.black87, // 선택되지 않은 탭의 텍스트 색상
        ),
      ),
      body: BackgroundContainer(
        child: TabBarView(
          controller: _tabController, // TabController 추가
          children: const [
            Center(child: CustomDivider()), // Room 탭의 내용
            Center(child: ImageListView()), // Item 탭의 내용
          ],
        ),
      ),
      floatingActionButton: const FAButton(),
    );
  }
}

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: const Color(0xFFF0F0F0),
      child: child, // 자식 위젯 삽입
    );
  }
}
