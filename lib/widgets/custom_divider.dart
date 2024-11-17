import 'package:flutter/material.dart';
import 'editDelete.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: roomData.map((room) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    room['text']!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.black),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const EditDelete(), // EditDelete 위젯
                          );
                        },
                      );
                    },
                  ),
                  onTap: () {

                  },
                ),
                const Divider(
                  color: Color(0xFFD6D6D6),
                  thickness: 2,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

final roomData = [
  {'text': '거실'},
  {'text': '부엌'},
  {'text': '방1'},
  {'text': '방2'},
  {'text': '방3'},
];
