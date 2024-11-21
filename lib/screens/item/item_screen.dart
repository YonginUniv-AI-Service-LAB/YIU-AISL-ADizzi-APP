import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/widgets/item_list_view.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/floating_add_button.dart';
import '../../widgets/time_sort_seletor.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool _isLatestSelected = true; // 초기값은 '최신등록순'임

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '서랍1',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "금쪽이의 방 > 가나 > 서랍1",
                  style: TextStyle(color: Colors.grey[600],fontSize: 12),
                ),
                TimeSortSelector(
                  isLatestSelected: _isLatestSelected,
                  onLatestTap: () {
                    setState(() {
                      _isLatestSelected = true;
                    });
                  },
                  onOldestTap: () {
                    setState(() {
                      _isLatestSelected = false;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(

            child: ItemListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingAddButton(
        onPressed: () {},
      ),
    );
  }
}


