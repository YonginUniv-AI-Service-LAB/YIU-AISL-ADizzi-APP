import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchList extends StatelessWidget {
  final List<String> searchData;

  const SearchList({super.key, required this.searchData});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: searchData.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.restore,size: 18,),
                const SizedBox(width: 25.0),
                Expanded(
                  child: Text(
                    searchData[index],
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: IconButton(
                    icon: const Icon(Icons.clear,size: 17,),
                    onPressed: () {

                    },
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
