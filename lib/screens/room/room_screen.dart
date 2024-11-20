import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/widgets/add_dialog.dart';
import '../../custom/room_search_bar.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/floating_add_button.dart';
import '../../widgets/image_list_view.dart';

class Room extends StatefulWidget {
  const Room({super.key});

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
              child: RoomCustomSearchBar(
                onTap: () {

                },
              ),
            ),
            const SizedBox(height: 1.0),
            TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFF5DDA6F),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Room'),
                Tab(text: 'Item'),
              ],
              labelColor: const Color(0xFF5DDA6F),
              unselectedLabelColor: Colors.black87,
            ),
            Expanded(
              child: Container(
                color: const Color(0xFFF0F0F0),
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    Center(child: CustomDivider()),
                    Center(child: ImageListView()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false, //뒷 배경 나타나게 하기
            builder: (BuildContext context) => const AddDialog(),
          );
        },
      ),

    );
  }
}

