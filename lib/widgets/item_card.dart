import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/models/item_model.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;

  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                item.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              // 경로
              Text(
                '금쪽이의 밤 > 옷장 > 서랍1', // 경로 텍스트
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 10), // 카드와 이름/경로 간 간격
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
                  if (item.imagePath != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.5, // 정방형 크기
                        child: Image.file(
                          File(item.imagePath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.grey[200],
                      child: Icon(Icons.image, color: Colors.grey, size: 50),
                    ),
                  SizedBox(height: 8),
                  // 카테고리
                  Text(
                    item.category,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  if (item.detail.isNotEmpty) ...[
                    SizedBox(height: 16),
                    // 상세 내용
                    Text(
                      item.detail,
                      style: TextStyle(fontSize: 14),
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