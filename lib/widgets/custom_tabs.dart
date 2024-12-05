import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/room_provider.dart';
import 'custom_divider.dart';
import 'image_list_view.dart';

class CustomTabs extends StatefulWidget {
  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // RoomProvider를 구독합니다.
    final roomProvider = Provider.of<RoomProvider>(context);

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF5DDA6F),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelColor: Colors.grey,
          labelColor: const Color(0xFF5DDA6F),
          tabs: const [
            Tab(text: "Room"),
            Tab(text: "Item"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              CustomDivider(roomList: roomProvider.roomList),
              const ImageListView(),
            ],
          ),
        ),
      ],
    );
  }
}