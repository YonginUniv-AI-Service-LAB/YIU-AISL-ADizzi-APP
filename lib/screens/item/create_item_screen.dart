import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import '../../widgets/camera_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';
import 'package:yiu_aisl_adizzi_app/widgets/category_selector.dart';
import 'package:yiu_aisl_adizzi_app/data/categories.dart';

class CreateItemScreen extends StatefulWidget {
  final int slotId;

  const CreateItemScreen({Key? key, required this.slotId}) : super(key: key);

  @override
  _CreateItemScreenState createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  String? _selectedMainCategory;
  String? _selectedSubCategory;
  int? _selectedCategoryCode;
  File? _selectedImage;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아이템 생성'),
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
              ),
              const SizedBox(height: 18),
              const Text('아이템 이름', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              CustomTextField(controller: _nameController),
              const SizedBox(height: 18),
              CategorySelector(
                label: '대분류',
                selectedCategory: _selectedMainCategory,
                onPressed: _showMainCategoryBottomSheet,
              ),
              const SizedBox(height: 18),
              CategorySelector(
                label: '소분류',
                selectedCategory: _selectedSubCategory,
                onPressed: _showSubCategoryBottomSheet,
              ),
              const SizedBox(height: 18),
              const Text('메모', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Container(
                constraints: const BoxConstraints(minHeight: 80, maxHeight: 200),
                child: CustomTextField(controller: _memoController, maxLines: 2),
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.bottomCenter,
                child: MainButton(
                  label: '저장',
                  onPressed: () {
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

                    if (_selectedCategoryCode == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("카테고리를 선택해주세요.")),
                      );
                      return;
                    }

                    final newItem = ItemModel(
                      itemId: DateTime.now().millisecondsSinceEpoch,
                      slotId: widget.slotId, // slotId를 추가
                      title: _nameController.text,
                      mainCategory: _selectedMainCategory!,
                      subCategory: _selectedSubCategory,
                      category: _selectedCategoryCode!,
                      detail: _memoController.text.isEmpty ? '메모 없음' : _memoController.text,
                      imageUrl: _selectedImage?.path,
                    );

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