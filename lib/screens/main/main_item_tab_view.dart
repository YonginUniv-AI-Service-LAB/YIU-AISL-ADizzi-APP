import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/image_list_view.dart';
import 'package:yiu_aisl_adizzi_app/widgets/item_card.dart';

class MainItemTabView extends StatelessWidget {
  final List<ItemModel> items;
  final Function loadData;

  const MainItemTabView({
    required this.items,
    required this.loadData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 한 줄에 3개의 이미지
        crossAxisSpacing: 8.0, // 이미지 간격
        mainAxisSpacing: 8.0, // 상하 간격
      ),
      padding: const EdgeInsets.all(5),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ItemCard(item: items[index]), // 팝업 창으로 띄움
                  ),
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3.0), // 선 추가
            ),
            child: Image.network(
              items[index].imageUrl!, // Use Image.asset for local images
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
