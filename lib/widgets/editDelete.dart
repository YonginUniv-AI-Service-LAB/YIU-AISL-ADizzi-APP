import 'package:flutter/material.dart';

class EditDelete extends StatelessWidget {
  const EditDelete({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.01,
      height: height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
      child: const Column(
        children: [
          // 수정 Row
          Row(

            children: [
              Icon(Icons.edit, color: Colors.black54),
              SizedBox(width: 15),
              Text('수정', style: TextStyle(fontSize: 16)),
            ]
          ),
          Divider(
            color: Color(0xFFD6D6D6),
            thickness: 2,
          ),
          Row(

            children: [
              Icon(Icons.delete, color: Colors.deepOrange),
              SizedBox(width: 15),
              Text(
                '삭제',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
