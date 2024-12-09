import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchList extends StatelessWidget {
  final List<String> searchData;
  final Function(String) onRemove;
  final TextEditingController controller;

  const SearchList({super.key, required this.searchData, required this.onRemove, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: searchData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Material로 감싼 InkWell을 추가
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // 클릭 시 페이지 이동 등
                      controller.text = searchData[index];
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.restore, size: 20), // 아이콘
                        const SizedBox(width: 10.0), // 아이콘과 텍스트 간 간격
                        Text(
                          searchData[index], // 텍스트
                          style: const TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
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
