import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/data/categories.dart';
import 'package:yiu_aisl_adizzi_app/service/image_service.dart';
import 'package:yiu_aisl_adizzi_app/service/item_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import '../../widgets/camera_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';
import '../../widgets/category_selector.dart';
import '../../data/categories.dart'; // 카테고리 목록을 가져옵니다.

class EditItemScreen extends StatefulWidget {
  final ItemModel item; // 기존 아이템을 받기 위해서

  EditItemScreen({required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  String? _selectedMainCategory;
  String? _selectedSubCategory;
  int? _selectedCategoryCode;
  int? _selectedCategory;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.item.title!;
    _memoController.text = widget.item.detail ?? '';
    // TODO: 메인, 서브 카테고리가 불러와지지 않음
    _selectedMainCategory = widget.item.mainCategory;
    _selectedSubCategory = widget.item.subCategory;
    _selectedCategory = widget.item.category;
  }

  // 예시 카테고리 리스트
  final List<String> _categories = [
    '카테고리 1',
    '카테고리 2',
    '카테고리 3',
    '카테고리 4',
    '카테고리 5',
  ];

  void _showMainCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: categories.keys.map((mainCategory) {
            return ListTile(
              title: Text(mainCategory),
              onTap: () {
                setState(() {
                  _selectedMainCategory = mainCategory;
                  _selectedSubCategory = null;
                  _selectedCategoryCode = categories[mainCategory]?.values.first;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showSubCategoryBottomSheet() {
    if (_selectedMainCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("먼저 대분류를 선택해주세요.")),
      );
      return;
    }

    final subCategories = categories[_selectedMainCategory!]!;

    if (subCategories.isEmpty) {
      // 소분류가 없는 경우
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("선택 가능한 소분류가 없습니다.")),
      );
      setState(() {
        _selectedSubCategory = _selectedMainCategory;
        _selectedCategoryCode = categories[_selectedMainCategory]?.values.first;
      });
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: subCategories.keys.map((subCategory) {
            return ListTile(
              title: Text(subCategory),
              onTap: () {
                setState(() {
                  _selectedSubCategory = subCategory;
                  _selectedCategoryCode = subCategories[subCategory];
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Future<int?> _getCategoryId(String? category) async {
    if (category == null) return null;

    // 선택된 대분류 카테고리에서 첫 번째 소분류 카테고리의 ID를 반환
    for (var mainCategory in categories.keys) {
      if (mainCategory == category) {
        return categories[mainCategory]?.values.first; // 첫 번째 소분류 카테고리 ID
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '물건 수정',
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
                imageUrl: widget.item.imageUrl,
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
              // 대분류 선택
              CategorySelector(
                label: '대분류',
                selectedCategory: _selectedMainCategory,
                onPressed: _showMainCategoryBottomSheet,
              ),
              const SizedBox(height: 18),

              // 소분류 선택
              CategorySelector(
                label: '소분류',
                selectedCategory: _selectedSubCategory,
                onPressed: _showSubCategoryBottomSheet,
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
                  onPressed: () async {
                    if (_nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("아이템 이름을 입력해주세요.")),
                      );
                      return;
                    }
                    if (_selectedCategoryCode == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("카테고리를 선택해주세요.")),
                      );
                      return;
                    }
                    int? imageId = _selectedImage == null ? null : await uploadImage(_selectedImage!.path);

                    await editItem(
                      context,
                      itemId: widget.item.itemId,
                      title: _nameController.text == widget.item.title ? null : _nameController.text,
                      category: _selectedCategoryCode == widget.item.category ? null : _selectedCategoryCode,
                      detail: _memoController.text == widget.item.detail ? null : _memoController.text,
                      imageId: imageId,
                    );

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
