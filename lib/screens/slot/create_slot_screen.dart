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
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:yiu_aisl_adizzi_app/widgets/create_slot_dialog.dart';

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

  // 카메라에서 이미지 선택
  Future<File?> _pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  // 이미지 크롭
  Future<File?> _cropImage(File imageFile) async {
    final CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '이미지 수정',
          toolbarColor: const Color(0xFF5DDA6F),
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
      ],
    );
    return cropped != null ? File(cropped.path) : null;
  }

  // 다이얼로그 호출
  void _showCreateContainerDialog() {
    showCreateSlotrDialog(
      context: context,
      imageUrl: widget.container.imageUrl,
      onCropImage: (File image) async {
        final croppedImage = await _cropImage(image);
        if (croppedImage != null) {
          setState(() {
            _selectedImage = croppedImage;
          });
        }
      },
      onPickFromCamera: _pickImageFromCamera,
    );
  }

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
              GestureDetector(
                onTap: _showCreateContainerDialog,
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    image: _selectedImage != null
                        ? DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.contain,
                    )
                        : null,
                  ),
                  child: _selectedImage == null
                      ? const Center(
                    child: Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: Colors.grey,
                    ),
                  )
                      : null,
                ),
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
              CustomTextField(controller: _controller),
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.bottomCenter,
                child: MainButton(
                  label: '저장',
                  onPressed: () async {
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

                    int? imageId = await uploadImage(_selectedImage!.path);
                    await createSlot(
                      context,
                      containerId: widget.container.containerId,
                      title: _controller.text,
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