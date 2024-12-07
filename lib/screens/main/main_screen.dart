import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/add_item_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/main/main_item_tab_view.dart';
import 'package:yiu_aisl_adizzi_app/screens/main/main_room_tab_view.dart';
import 'package:yiu_aisl_adizzi_app/service/room_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import '../../widgets/room_search_bar.dart';
import '../../widgets/add_dialog.dart';
import '../../widgets/floating_add_button.dart';
import '../../widgets/image_list_view.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<RoomModel>? _rooms;
  List<ItemModel>? _items;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadRoomData();
    _loadItemData();
  }

  Future<void> _loadRoomData() async{
    _rooms = await getRooms(context, sortBy: 'recent');
    setState(() {});
  }

  Future<void> _loadItemData() async{
    // _items = await getItems(context, sortBy: 'recnet');
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    _rooms == null
                        ? Center(child: CircularProgressIndicator())
                        : MainRoomTabView(rooms: _rooms!, loadData: _loadRoomData,),
                    MainItemTabView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () {
          if ( _tabController.index == 0 ) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => AddDialog(isEdit: false,),
            ).then((_) {
              _loadRoomData();
            });
          }
          if ( _tabController.index == 1) {
            // TODO: 물건 저장 위치 먼저 선택 후 화면 전환하도록 수정
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddItemScreen(), // 수정할 아이템을 넘겨줌
              ),
            );
          }
        },
      ),
    );
  }
}