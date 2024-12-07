import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/service/image_service.dart';
import 'package:yiu_aisl_adizzi_app/service/item_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
// import 'package:yiu_aisl_adizzi_app/models/item_model.dart';
import '../../widgets/camera_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';
import 'package:yiu_aisl_adizzi_app/widgets/category_selector.dart';

class CreateItemScreen extends StatefulWidget {
  // 생성자에서 아이템을 받을 수 있도록
  CreateItemScreen();

  @override
  _CreateItemScreenState createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  String? _selectedCategory;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
  }

  // 예시 카테고리 리스트
  final List<String> _categories = [
    '카테고리 1',
    '카테고리 2',
    '카테고리 3',
    '카테고리 4',
    '카테고리 5',
  ];

  void _showCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_categories[index]),
              onTap: () {
                setState(() {
                  _selectedCategory = _categories[index];
                });
                Navigator.pop(context); // 바텀 시트 닫기
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '물건 등록',
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
              CameraWidget(
                onImageSelected: (image) {
                  setState(() {
                    _selectedImage = image;
                  });
                },
                initialImage: _selectedImage,
              ),
              const SizedBox(height: 18),
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
              const Text(
                '카테고리',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              // 분리된 CategorySelector 위젯 사용
              CategorySelector(
                selectedCategory: _selectedCategory,
                onPressed: _showCategoryBottomSheet,
              ),
              const SizedBox(height: 18),
              const Text(
                '메모',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                constraints: const BoxConstraints(
                  minHeight: 80,
                  maxHeight: 200,
                ),
                child: CustomTextField(
                  controller: _memoController,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.bottomCenter,
                child: MainButton(
                  label: '저장',
                  onPressed: () async{
                    if (_nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("아이템 이름을 입력해주세요.")),
                      );
                      return;
                    }

                    if (_selectedImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("사진을 등록해주세요.")),
                      );
                      return;
                    }

                    // TODO: slotId 를 선택할 수 있는 tree UI 필요

                    // int? imageId = await uploadImage(_selectedImage!.path);

                    // await createItem(context, slotId: widget.slotId,
                    //   title: _nameController.text,
                    //   // TODO: 카테고리 작업 필요
                    //   category: 1,
                    //   detail: _memoController.text ?? '설명 없음',
                    //   imageId: imageId,
                    // );

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