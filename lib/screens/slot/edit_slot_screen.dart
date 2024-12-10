import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/tree_provider.dart';
import 'package:yiu_aisl_adizzi_app/service/container_service.dart';
import 'package:yiu_aisl_adizzi_app/service/image_service.dart';
import 'package:yiu_aisl_adizzi_app/service/slot_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/camera_crop_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';

class EditSlotScreen extends StatefulWidget {
  final SlotModel slot;

  const EditSlotScreen({required this.slot, Key? key}) : super(key: key);

  @override
  _EditSlotScreenState createState() => _EditSlotScreenState();
}

class _EditSlotScreenState extends State<EditSlotScreen> {
  final TextEditingController _controller = TextEditingController();
  File? _selectedImage; // 선택한 이미지

  @override
  void initState() {
    super.initState();
    _controller.text = widget.slot.title!;
    Provider.of<TreeProvider>(context, listen: false).fetchTree(context);
  }

  @override
  Widget build(BuildContext context) {
    final container = Provider.of<TreeProvider>(context).getContainerBySlotId(widget.slot.slotId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          container?.title! ?? '수납장 이름 조회 오류',
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
                    _selectedImage = image; // 선택된 이미지를 저장
                  });
                },
                initialImage: _selectedImage, // 초기 선택된 이미지
                imageUrl: widget.slot.imageUrl, // 기존 슬롯 이미지 URL
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

                    // 이미지 업로드 로직
                    int? imageId = _selectedImage == null ? null : await uploadImage(_selectedImage!.path);

                    // 슬롯 데이터 업데이트
                    await editSlot(
                      context,
                      slotId: widget.slot.slotId,
                      title: _controller.text == widget.slot.title ? null : _controller.text,
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
