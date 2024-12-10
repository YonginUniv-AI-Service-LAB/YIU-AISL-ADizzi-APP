import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/tree_provider.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';

class ItemCard extends StatefulWidget {
  final ItemModel item;

  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  void initState() {
    super.initState();
    Provider.of<TreeProvider>(context, listen: false).fetchTree(context);
  }

  @override
  Widget build(BuildContext context) {
    final path = Provider.of<TreeProvider>(context).getPathBySlotId(widget.item.slotId!);

    return Padding(
      padding: const EdgeInsets.all(5.0), // 카드와 동일한 외부 패딩
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 이름과 경로
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이름
              Text(
                widget.item.title!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              // 경로
              Text(
                path,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10), // 카드와 이름/경로 간 간격
          // 카드 내용
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0), // 카드 내부 패딩
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 이미지 (정방형)
                  if (widget.item.imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.5, // 정방형 크기
                        child: Image.network(
                          widget.item.imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, color: Colors.grey, size: 50),
                    ),
                  const SizedBox(height: 8),
                  // 카테고리 표시
                  Text(
                    // TODO: 충돌 해결 후 카테고리 대분류 + 소분류로 표현할 수 있도록 수정할 것
                    getCategoryName(widget.item.category),
                    // item.category.toString(),
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  if (widget.item.detail!.isNotEmpty) ...[
                    SizedBox(height: 16),
                    // 상세 내용
                    Text(
                      widget.item.detail!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
