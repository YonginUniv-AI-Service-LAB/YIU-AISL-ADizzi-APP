import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/service/service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';

import '../../service/search.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;

  const SearchResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$query 검색 결과'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<ItemModel>>(
        future: getSearch(context, query: query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터 로딩 중
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 오류 발생 시
            return Center(child: Text('오류 발생: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // 검색 결과가 없을 때
            return Center(child: Text('검색 결과가 없습니다.'));
          } else {
            // 검색 결과 데이터가 있을 때
            List<ItemModel> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.title!),

                  onTap: () {
                    // 아이템 클릭 시 상세 페이지로 이동
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
