import 'package:flutter/material.dart';

class SearchDetailList extends StatelessWidget {
  final List<String> searchDetailData;
  final List<String> searchPathData;
  final Function(int) onDelete;

  const SearchDetailList({
    super.key,
    required this.searchDetailData,
    required this.searchPathData,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: searchDetailData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {


                        },
                        child: Row(
                          children: [
                            const Icon(Icons.restore, size: 20),
                            const SizedBox(width: 25),
                            Text(
                              searchDetailData[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),

                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // IconButton outside InkWell
                  IconButton(
                    icon: const Icon(Icons.clear, size: 18),
                    onPressed: () {
                      onDelete(index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
