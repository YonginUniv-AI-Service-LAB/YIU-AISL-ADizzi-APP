import 'package:flutter/material.dart';

class CustomTabs extends StatelessWidget {
  const CustomTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample> {
  String _selectedTab = 'one';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Item One',
                  style: TextStyle(
                    color: _selectedTab == 'one' ? const Color(0xFF5DDA6F) : const Color(0xFF49454F),
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Item Two',
                  style: TextStyle(
                    color: _selectedTab == 'two' ? const Color(0xFF5DDA6F) : Color(0xFF49454F),
                  ),
                ),
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedTab = index == 0 ? 'one' : 'two';
              });
            },
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}
