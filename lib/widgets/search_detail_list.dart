import 'package:flutter/material.dart';

class SearchDetailList extends StatelessWidget {
  final List<String> searchDetailData;
  final List<String> searchPathData;

  const SearchDetailList({
    super.key,
    required this.searchDetailData,
    required this.searchPathData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: searchDetailData.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(

              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.restore, size: 20),
                    const SizedBox(width: 25),
                    Flexible(
                      child: Text(
                        searchDetailData[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      searchPathData[index],
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
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
