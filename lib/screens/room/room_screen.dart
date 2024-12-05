import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/room_search_bar.dart';
import '../../provider/room_provider.dart';
import '../../widgets/add_dialog.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/floating_add_button.dart';
import '../../widgets/image_list_view.dart';


class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 방 목록을 초기화할 때 서버에서 데이터를 가져옴
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RoomProvider>(context, listen: false).getRoom();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,   //키보드 화면 밀지 않도록
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
              child: RoomCustomSearchBar(
                onTap: () {},
              ),
            ),
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
                  children: [
                    Consumer<RoomProvider>(
                      builder: (context, roomProvider, child) {
                        return CustomDivider(
                          roomList: roomProvider.roomList, // RoomProvider에서 가져온 List<RoomModel>을 전달
                        );
                      },

                    ),


                    const Center(child: ImageListView()),
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
            barrierDismissible: false,
            builder: (BuildContext context) => AddDialog(isEdit: false,),
          );
        },
      ),
    );
  }
}
