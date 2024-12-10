import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/create_item_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/main/main_item_tab_view.dart';
import 'package:yiu_aisl_adizzi_app/screens/main/main_room_tab_view.dart';
import 'package:yiu_aisl_adizzi_app/service/item_service.dart';
import 'package:yiu_aisl_adizzi_app/service/room_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import '../../provider/tree_provider.dart';
import '../../widgets/main_search_bar.dart';
import '../../widgets/add_dialog.dart';
import '../../widgets/floating_add_button.dart';
import '../../widgets/image_list_view.dart';
import 'main_folder_tree.dart';


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
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _loadRoomData();
    _loadItemData();
    // TreeProvider에서 트리 데이터 로드
    final treeProvider = Provider.of<TreeProvider>(context, listen: false);
    treeProvider.fetchTree(context);
  }

  Future<void> _loadRoomData() async{
    _rooms = await getRooms(context, sortBy: 'recent');
    setState(() {});
  }

  Future<void> _loadItemData() async{
    _items = await getAllItems(context, sortBy: 'recnet');
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
      drawer: Drawer(
        child: MainFolderTree(), // 여기에 폴더 트리 UI 삽입
      ),
      resizeToAvoidBottomInset: false,   //키보드 화면 밀지 않도록
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
              child: MainSearchBar(
                onTap: () {},
              ),
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFF5DDA6F),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: '공간'),
                Tab(text: '물건'),
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
                    _items == null
                        ? Center(child: CircularProgressIndicator())
                        : MainItemTabView(items: _items!, loadData: _loadRoomData,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () {
          if (_tabController.index == 0) {
            // Room을 추가하는 로직
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => AddDialog(isEdit: false),
            ).then((_) {
              _loadRoomData();
            });
          }
          if (_tabController.index == 1) {
            // 아이템을 추가하는 로직
            final selectedSlotId = _items?.first.slotId ?? 0;  // 아이템이 없으면 기본값 0을 사용
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateItemScreen(), // 수정할 아이템을 넘겨줌
              ),
            ).then((_) {
              _loadItemData();
            });
          }
        },
      ),
    );
  }
}