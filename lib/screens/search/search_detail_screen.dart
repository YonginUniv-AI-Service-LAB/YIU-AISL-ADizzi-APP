import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/search_detail_list.dart';

class SearchDetail extends StatelessWidget {




  final List<String> searchDetailData = [
    '야구',
    '야놀자',
    '약국',
    '야후꾸러기'
  ];
  final List<String> searchPathData = [
    '방> 컨테이너 > 슬롯 > 아이템',
    '금쪽이방>  > 옷장 > 서랍1',
    '금쪽이방>  > 옷장 > 서랍1',
    '금쪽이방>  > 옷장 > 서랍1',
  ];

   SearchDetail({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('야'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w700,

        ),
        titleSpacing: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFF5DDA6F),
          ),
        ),
      ),
        body: Column(
          children: [
            Container(
              height: height * 0.03,
              color: Colors.white,
            ),
            Expanded(
              child: SearchDetailList(
                searchPathData: searchPathData,
                searchDetailData: searchDetailData,
              ),
            ),
          ],
        )

    );
  }
}
