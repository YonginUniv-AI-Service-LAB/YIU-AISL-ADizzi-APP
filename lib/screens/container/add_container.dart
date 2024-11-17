import 'package:flutter/material.dart';

import '../../widgets/custom_save_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';


class AddContainerPage extends StatefulWidget {
  final Function(String) onAdd;

  AddContainerPage({required this.onAdd});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddContainerPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false, // 키보드 올라올 때 앱바 색 유지  //색상은 유지가 되는데 스크롤이 안됨ㅠㅠ
      appBar: AppBar(
        title: const Text(
          '금쪽이의 방',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 카메라 박스 틀
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // 수납장 이름 텍스트
              const Text(
                '수납장 이름',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),

              // 커스텀 텍스트 필드 사용
              CustomTextField(controller: _controller),

              SizedBox(height: 100),

              // Align으로 버튼 고정
              Align(
                alignment: Alignment.bottomCenter,
                child: MainButton(
                  label: '저장',
                  onPressed: () {
                    widget.onAdd(_controller.text);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}