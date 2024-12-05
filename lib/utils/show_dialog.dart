import 'package:flutter/material.dart';

void showErrorDialog(
    BuildContext context,
    String message
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFFFFFFF),
        title: Text('오류'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFFFFFFFF),
              foregroundColor: Color(0xFF5589D3),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('확인'),
          ),
        ],
      );
    },
  );
}