import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/service/image_service.dart';
import 'package:yiu_aisl_adizzi_app/service/item_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import '../../widgets/camera_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';
import 'package:yiu_aisl_adizzi_app/widgets/category_selector.dart';
import 'package:yiu_aisl_adizzi_app/utils/categories.dart';

class AddItemScreen extends StatefulWidget {
  final int slotId;
  // final ItemModel? item; // 기존 아이템을 받기 위해서
  // 생성자에서 아이템을 받을 수 있도록
  AddItemScreen({required this.slotId});


  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  int? _selectedCategoryCode;
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
          '물건 추가/수정',
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
                        const SnackBar(content: Text("물건 이름을 입력해주세요.")),
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

                    int? imageId = await uploadImage(_selectedImage!.path);

                    await createItem(context, slotId: widget.slotId,
                      title: _nameController.text,
                      category: _selectedCategoryCode,
                      detail: _memoController.text ?? '설명 없음',
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