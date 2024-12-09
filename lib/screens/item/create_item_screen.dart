import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/service/image_service.dart';
import 'package:yiu_aisl_adizzi_app/service/item_service.dart';
import 'package:yiu_aisl_adizzi_app/widgets/move_tree.dart';
import '../../widgets/camera_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';
import 'package:yiu_aisl_adizzi_app/widgets/category_selector.dart';
import 'package:yiu_aisl_adizzi_app/data/categories.dart';

class CreateItemScreen extends StatefulWidget {
  CreateItemScreen();

  @override
  _CreateItemScreenState createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  String? _selectedCategoryKey;
  String? _selectedSubCategoryKey;
  int? _selectedCategoryId;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
  }

  // 카테고리 선택 모달 시트
  void _showCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: categories.keys.map((mainCategory) {
            return ExpansionTile(
              title: Text(mainCategory),
              children: categories[mainCategory]!.keys.map((subCategory) {
                return ListTile(
                  title: Text(subCategory),
                  onTap: () {
                    setState(() {
                      _selectedCategoryKey = mainCategory;
                      _selectedSubCategoryKey = subCategory;
                      _selectedCategoryId = categories[mainCategory]![subCategory];
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            );
          }).toList(),
        );
      },
    );
  }

  // 공통 에러 메시지 처리
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // 저장 버튼 동작
  void _handleSave() {
    if (_nameController.text.isEmpty) {
      _showErrorSnackBar("아이템 이름을 입력해주세요.");
      return;
    }

    if (_selectedImage == null) {
      _showErrorSnackBar("사진을 등록해주세요.");
      return;
    }

    if (_selectedCategoryId == null) {
      _showErrorSnackBar("카테고리를 선택해주세요.");
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoveTree(
          isCreate: true,
          slotIdFunction: (slotId) async {
            try {
              int? imageId = await uploadImage(_selectedImage!.path);

              await createItem(
                context,
                slotId: slotId,
                title: _nameController.text,
                category: _selectedCategoryId!, // 카테고리 ID 사용
                detail: _memoController.text.isNotEmpty
                    ? _memoController.text
                    : '설명 없음',
                imageId: imageId,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('아이템이 생성되었습니다.')),
              );
              Navigator.pop(context); // MoveTree로부터 Pop
            } catch (e) {
              _showErrorSnackBar('아이템 생성 실패: $e');
            }
          },
        ),
      ),
    ).then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '물건 등록',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              CustomTextField(controller: _nameController),
              const SizedBox(height: 18),
              const Text(
                '카테고리',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              CategorySelector(
                selectedCategory: _selectedSubCategoryKey ?? '카테고리를 선택하세요',
                label: '카테고리',
                onPressed: _showCategoryBottomSheet,
              ),
              const SizedBox(height: 18),
              const Text(
                '메모',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
                  onPressed: _handleSave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}