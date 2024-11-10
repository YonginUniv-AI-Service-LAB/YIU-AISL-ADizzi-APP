import 'package:flutter/material.dart';

import '../widgets/custom_divider.dart';
import '../widgets/image_list_view.dart';

class CustomTabs extends StatefulWidget {
  @override
  _CustomTabsState createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: ScaffoldState());
  }

  @override
  Widget build(BuildContext context) {
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
            children: const [
              CustomDivider(),
              ImageListView(),
            ],
          ),
        ),
      ],
    );
  }
}

