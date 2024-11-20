import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/widgets/item_list_view.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/custom_container_add_button.dart';

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
      body: SingleChildScrollView( // 스크롤 가능하도록 추가
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '금쪽이의 방 > 옷장 > 서랍1',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLatestSelected = true;
                          });
                        },
                        child: Text(
                          '최신등록순',
                          style: TextStyle(
                            fontSize: 14,
                            color: _isLatestSelected
                                ? const Color(0xFF5DDA6F)
                                : Colors.black,
                          ),
                        ),
                      ),
                      const Text(
                        ' / ',
                        style: TextStyle(
                          color: Color(0xFF595959),
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLatestSelected = false;
                          });
                        },
                        child: Text(
                          '오래된순',
                          style: TextStyle(
                            fontSize: 14,
                            color: !_isLatestSelected
                                ? const Color(0xFF5DDA6F)
                                : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.swap_vert, color: Colors.black),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ItemListView(),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomContainerAddButton(
        onPressed: () {},
      ),
    );
  }
}


