import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchList extends StatelessWidget {
  final List<String> searchData;
  final List<String> searchItemImg;

  const SearchList({super.key, required this.searchData, required this.searchItemImg});


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
                /* Image.asset(
                        searchItemImg[index],
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                      ), 해당 이미지 띄우게 하기 */
                const Icon(Icons.restore, size: 20,),
                const SizedBox(width: 25.0),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // 해당 키워드 클릭시 페이지 이동
                      },
                      child: Text(
                        searchData[index],
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