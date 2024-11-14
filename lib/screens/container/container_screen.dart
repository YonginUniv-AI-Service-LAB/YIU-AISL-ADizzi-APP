import 'package:flutter/material.dart';
import '../../custom/search_bar.dart';
import '../../widgets/custom_container_add_button.dart';
import 'add_container.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({super.key});

  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  bool _isLatestSelected = true; // 초기값은 '최신등록순'임

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '금쪽이의 방',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view),
            onPressed: () {
              // main item 페이지로 이동
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AnotherPage()),
              // );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const CustomSearchBar(

          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                      color: _isLatestSelected ? Color(0xFF5DDA6F) : Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 10),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLatestSelected = false;
                    });
                  },
                  child: Text(
                    '오래된순',
                    style: TextStyle(
                      color: !_isLatestSelected ? Color(0xFF5DDA6F) : Colors.black,
                    ),
                  ),
                ),

                Icon(Icons.swap_vert, color: Colors.black),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                '추가된 아이템이 없습니다.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: CustomContainerAddButton(
        onPressed: () {
          // add container 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContainerPage(onAdd: (item) {})),
          );
        },
      ),
    );
  }
}