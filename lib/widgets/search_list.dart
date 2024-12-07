import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchList extends StatelessWidget {
  final List<String> searchData;
  final Function(String) onRemove;

  const SearchList({super.key, required this.searchData, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: searchData.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // 클릭 시 페이지 이동 등
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 10.0),
                          const Icon(Icons.restore, size: 20),
                          const SizedBox(width: 25.0),
                          Text(
                            searchData[index],
                            style: const TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: IconButton(
                    icon: const Icon(Icons.clear, size: 17),
                    onPressed: () {
                      onRemove(searchData[index]);
                    },
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

