import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/models/item_model.dart';
import '../../widgets/camera_widget.dart'; // CameraWidget이 정의된 경로
import '../../widgets/custom_textfield.dart'; // CustomTextField 경로
import '../../widgets/main_button.dart'; // MainButton 경로
import 'package:yiu_aisl_adizzi_app/models/item_model.dart';

class AddItemsPage extends StatefulWidget {
  @override
  _AddItemsPageState createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  String? _selectedCategory;
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '아이템 추가',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CameraWidget for selecting an image
              CameraWidget(
                onImageSelected: (image) {
                  setState(() {
                    _selectedImage = image;
                  });
                },
                initialImage: _selectedImage,
              ),
              const SizedBox(height: 18),
              // Item Name Field
              const Text(
                '아이템 이름',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(controller: _nameController),
              const SizedBox(height: 18),
              // Category Dropdown (Optional)
              const Text(
                '카테고리',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // 둥글게 설정
                    borderSide: BorderSide(color: Color(0x8049454F)), // 기본 테두리 색상
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // 둥글게 설정
                    borderSide: BorderSide(color: Color(0x8049454F)), // 활성화 상태의 테두리 색상
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10), // 기존 패딩 유지
                ),
                items: [], // 빈 리스트로 설정
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                value: _selectedCategory,
              ),
              const SizedBox(height: 18),
              // Memo Field (Optional)
              const Text(
                '메모',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                constraints: BoxConstraints(
                  minHeight: 80, // 최소 높이 지정
                  maxHeight: 200, // 최대 높이 지정
                ),
                child: CustomTextField(
                  controller: _memoController,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 30),
              // Save Button
              Align(
                alignment: Alignment.bottomCenter,
                child: MainButton(
                  label: '저장',
                  onPressed: () {
                    // 아이템 이름이 비어있을 경우
                    if (_nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("아이템 이름을 입력해주세요.")),
                      );
                      return;
                    }

                    // 이미지가 선택되지 않았다면
                    if (_selectedImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("사진을 등록해주세요.")),
                      );
                      return;
                    }

                    // ItemModel 객체 생성 (카테고리와 메모는 입력하지 않아도 기본값 사용)
                    final newItem = ItemModel(
                      title: _nameController.text,
                      category: _selectedCategory ?? '기본 카테고리', // 카테고리 없으면 기본값 설정
                      detail: _memoController.text.isEmpty ? '메모 없음' : _memoController.text, // 메모 없으면 기본값 설정
                      imagePath: _selectedImage?.path,
                    );

                    // saving logic
                    print('저장 완료:');
                    print('이름: ${_nameController.text}');
                    print('카테고리: ${newItem.category}');
                    print('메모: ${newItem.detail}');
                    print('이미지: ${_selectedImage?.path}');

                    Navigator.pop(context, newItem);
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
