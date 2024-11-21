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
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height* 0.75,
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0),
      padding: const EdgeInsets.all(10),
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
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.check_box_outline_blank),
                    onPressed: () {},
                  ),


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
                    child: ListTile(
                      title: Text(
                        item.text,  // item.text를 title에 넣기
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
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
