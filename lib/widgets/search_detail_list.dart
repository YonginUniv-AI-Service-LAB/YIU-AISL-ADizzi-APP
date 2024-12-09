import 'package:flutter/material.dart';

class SearchDetailList extends StatelessWidget {
  final List<String> searchDetailData;
  final Function(int) onDelete;
  final TextEditingController controller;
  final VoidCallback setState;

  const SearchDetailList({
    super.key,
    required this.searchDetailData,
    required this.onDelete,
    required this.controller,
    required this.setState,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: searchDetailData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.text = searchDetailData[index];
                      setState();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.restore, size: 22),
                        const SizedBox(width: 20),
                        Text(
                          searchDetailData[index],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            onDelete(index);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
