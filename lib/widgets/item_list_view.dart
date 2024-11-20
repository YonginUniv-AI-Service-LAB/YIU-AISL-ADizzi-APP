import 'package:flutter/material.dart';

class ItemListView extends StatelessWidget {
  // Mock data for the list
  final List<ItemData> itemData = [
    ItemData(text: '패딩', img: 'assets/images/ADizziLogo.png'),
    ItemData(text: '코트', img: 'assets/images/ADizziLogo.png'),
    ItemData(text: '자켓', img: 'assets/images/ADizziLogo.png'),
    ItemData(text: '점퍼', img: 'assets/images/ADizziLogo.png'),
    ItemData(text: '가디건', img: 'assets/images/ADizziLogo.png'),
  ];

  ItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),

      ),
      child: Column(
        children: itemData.asMap().entries.map((entry) {
          int index = entry.key;
          ItemData item = entry.value;

          return Column(
            children: [
              Row(
                children: [
                  // Checkbox Icon
                  IconButton(
                    icon: const Icon(Icons.check_box_outline_blank),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),

                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.img,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Text
                  Expanded(
                    child: Text(
                      item.text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // More options icon
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
              // Divider (밑줄)
              if (index != itemData.length - 1) // 마지막 아이템에는 선 추가 X
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                  height: 16,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class ItemData {
  final String text;
  final String img;

  ItemData({required this.text, required this.img});
}
