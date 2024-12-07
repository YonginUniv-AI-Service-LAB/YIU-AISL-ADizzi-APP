import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import '../../widgets/camera_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';
import 'package:yiu_aisl_adizzi_app/widgets/category_selector.dart';
import 'package:yiu_aisl_adizzi_app/data/categories.dart';

class AddItemScreen extends StatefulWidget {
  final ItemModel? item; // 기존 아이템을 받기 위해서
  AddItemScreen({this.item});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  String? _selectedMainCategory;
  String? _selectedSubCategory;
  int? _selectedCategoryCode;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.title!;
      _memoController.text = widget.item!.detail ?? '';
      _selectedMainCategory = widget.item!.mainCategory;
      _selectedSubCategory = widget.item!.subCategory;
      _selectedCategoryCode = widget.item!.category;
      if (widget.item!.imageUrl != null) {
        _selectedImage = File(widget.item!.imageUrl!);
      }
    }
  }

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
                      itemId: 1,
                      title: _nameController.text,
                      mainCategory: _selectedMainCategory!,
                      subCategory: _selectedSubCategory ?? null,
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