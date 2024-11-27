import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget extends StatefulWidget {
  final Function(File?) onImageSelected;

  const CameraWidget({required this.onImageSelected, Key? key}) : super(key: key);

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _openCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        widget.onImageSelected(_selectedImage);
      }
    } catch (e) {
      print("카메라에서 이미지를 가져오는 중 오류 발생: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openCamera,
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
          image: _selectedImage != null
              ? DecorationImage(
            image: FileImage(_selectedImage!),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: _selectedImage == null
            ? const Center(
          child: Icon(
            Icons.camera_alt,
            size: 30,
            color: Colors.white,
          ),
        )
            : null,
      ),
    );
  }
}
