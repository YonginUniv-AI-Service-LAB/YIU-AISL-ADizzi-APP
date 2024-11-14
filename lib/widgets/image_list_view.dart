import 'package:flutter/material.dart';

class ImageListView extends StatelessWidget {
  const ImageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 한 줄에 3개의 이미지
        crossAxisSpacing: 8.0, // 이미지 간격
        mainAxisSpacing: 8.0, // 상하 간격
      ),
      padding: const EdgeInsets.all(5),
      itemCount: itemData.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3.0), // 선 추가
          ),
          child: Image.asset(
            itemData[index]['img']!, // Use Image.asset for local images
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

final itemData = [
  {'img': 'assets/images/ADizziLogo.png'},
  {'img': 'assets/images/a.jpg'},
  {'img': 'assets/images/yongduMarketIcon.png'},
  {'img': 'assets/images/a.jpg'},
  {'img': 'assets/images/ADizziLogo.png'},
  {'img': 'assets/images/ADizziLogo.png'},
  {'img': 'assets/images/b.jpg'},
  {'img': 'assets/images/e.jpg'},
  {'img': 'assets/images/ADizziLogo.png'},
  {'img': 'assets/images/f.webp'},
  {'img': 'assets/images/ADizziLogo.png'},
  {'img': 'assets/images/c.jpg'},
];
