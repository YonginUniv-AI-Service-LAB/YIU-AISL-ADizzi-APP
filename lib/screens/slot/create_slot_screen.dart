import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/tree_provider.dart';
import 'package:yiu_aisl_adizzi_app/service/container_service.dart';
import 'package:yiu_aisl_adizzi_app/service/image_service.dart';
import 'package:yiu_aisl_adizzi_app/service/slot_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/camera_crop_widget.dart'; // CameraCropWidget 가져오기
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';

class CreateSlotScreen extends StatefulWidget {
  final ContainerModel container;

  const CreateSlotScreen({required this.container, Key? key})
      : super(key: key);

  @override
  _CreateSlotScreenState createState() => _CreateSlotScreenState();
}

class _CreateSlotScreenState extends State<CreateSlotScreen> {
  final TextEditingController _controller = TextEditingController();
  File? _selectedImage; // 선택한 이미지

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.container.title!,
          style: const TextStyle(
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
              CameraCropWidget(
                onImageSelected: (image) {
                  setState(() {
                    _selectedImage = image; // 선택한 이미지를 저장
                  });
                },
                imageUrl: widget.container.imageUrl,
              ),
              const SizedBox(height: 30),
              const Text(
                '수납칸 이름',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextField(controller: _controller), // 수납칸 이름 입력 필드
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.bottomCenter,
                child: MainButton(
                  label: '저장',
                  onPressed: () async {
                    // 필수 입력값 확인
                    if (_controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("수납칸 이름을 입력해주세요.")),
                      );
                      return;
                    }
                    if (_selectedImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("사진을 등록해주세요.")),
                      );
                      return;
                    }

                    // 이미지를 업로드하고 슬롯을 생성
                    int? imageId = await uploadImage(_selectedImage!.path);
                    await createSlot(
                      context,
                      containerId: widget.container.containerId,
                      title: _controller.text,
                      imageId: imageId,
                    );

                    // 이전 화면으로 돌아가기
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