import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/model.dart';

class SearchList extends StatelessWidget {
  final List<ItemModel> searchData;

  const SearchList({super.key, required this.searchData});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: searchData.length,
        itemBuilder: (context, index) {
          final item = searchData[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.restore, size: 20),
                const SizedBox(width: 25.0),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // 해당 키워드 클릭시 페이지 이동
                      },
                      child: Text(
                        item.title ?? '제목 없음',
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: IconButton(
                    icon: const Icon(Icons.clear, size: 17),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
