import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/utils/categories.dart';
import 'package:yiu_aisl_adizzi_app/service/image_service.dart';
import 'package:yiu_aisl_adizzi_app/service/item_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import '../../widgets/camera_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';
import '../../widgets/category_selector.dart';
import '../../utils/categories.dart'; // 카테고리 목록을 가져옵니다.

class EditItemScreen extends StatefulWidget {
  final ItemModel item; // 기존 아이템을 받기 위해서

  EditItemScreen({required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  int? _selectedCategoryCode;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.item.title!;
    _memoController.text = widget.item.detail ?? '';
    _selectedCategoryCode = widget.item.category;
  }

  // 카테고리 선택 모달 시트
  void _showCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: categories.keys.map((mainCategory) {

            if(categories[mainCategory] != null && categories[mainCategory]!.length == 1) {
              return ListTile(
                title: Text(mainCategory),
                onTap: () {
                  setState(() {
                    _selectedCategoryCode = categories[mainCategory]![mainCategory];
                  });
                  Navigator.pop(context);
                },
              );
            }

            return ExpansionTile(
              title: Text(mainCategory),
              children: categories[mainCategory]!.keys.map((subCategory) {
                return ListTile(
                  title: Text(subCategory),
                  onTap: () {
                    setState(() {
                      _selectedCategoryCode = categories[mainCategory]![subCategory];
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
                '물건 이름',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(controller: _nameController),
              const SizedBox(height: 10),
              CategorySelector(
                selectedCategory: _selectedCategoryCode == null ? '카테고리를 선택하세요' : getCategoryName(_selectedCategoryCode),
                label: '카테고리',
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
