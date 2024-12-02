import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/models/item_model.dart';
import '../../widgets/camera_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';
import 'package:yiu_aisl_adizzi_app/widgets/category_selector.dart';

class AddItemsPage extends StatefulWidget {
  final ItemModel? item; // 기존 아이템을 받기 위해서
  // 생성자에서 아이템을 받을 수 있도록
  AddItemsPage({this.item});

  @override
  _AddItemsPageState createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  String? _selectedCategory;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.title;
      _memoController.text = widget.item!.detail ?? '';
      _selectedCategory = widget.item!.category;
      if (widget.item!.imagePath != null) {
        _selectedImage = File(widget.item!.imagePath!);
      }
    }
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

                    final newItem = ItemModel(
                      title: _nameController.text,
                      category: _selectedCategory ?? '기본 카테고리',
                      detail: _memoController.text.isEmpty ? '메모 없음' : _memoController.text,
                      imagePath: _selectedImage?.path,
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