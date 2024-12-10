import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:yiu_aisl_adizzi_app/service/image_service.dart';

class CameraCropWidget extends StatefulWidget {
  final Function(File?) onImageSelected; // 부모로 선택된 이미지를 전달하는 콜백 함수
  final File? initialImage; // 초기 이미지 (선택된 이미지)
  final String? imageUrl; // 기존 이미지 URL

  const CameraCropWidget({
    required this.onImageSelected,
    this.initialImage,
    this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  _CameraCropWidgetState createState() => _CameraCropWidgetState();
}

class _CameraCropWidgetState extends State<CameraCropWidget> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    // 초기 이미지 설정
    _selectedImage = widget.initialImage;
  }

  // 카메라 열기
  Future<void> _openCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final croppedFile = await _cropImage(File(pickedFile.path));
        // final croppedFile = await _cropImageUrl());
        if (croppedFile != null) {
          setState(() {
            _selectedImage = croppedFile;
          });
          widget.onImageSelected(_selectedImage); // 부모로 이미지 전달
        }
      }
    } catch (e) {
      debugPrint("Error picking or cropping image: $e");
    }
  }

  // 이미지 크롭
  Future<File?> _cropImageUrl({required String imageUrl}) async {
    try {
      File imageFile = await downloadImage(imageUrl);
      return _cropImage(imageFile);
    } catch (e) {
      debugPrint("Error during image download: $e");
      return null;
    }
  }

  // 이미지 크롭
  Future<File?> _cropImage(File imageFile) async {
    try {
      final CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '이미지 크롭',
            toolbarColor: Color(0xFF5DDA6F),
            toolbarWidgetColor: Colors.white,
            // square만 넣을지?
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          // IOSUiSettings(
          //   title: '이미지 크롭',
          //   aspectRatioLockEnabled: false,
          // ),
        ],
      );
      if (cropped != null) {
        return File(cropped.path); // 크롭된 파일 반환
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Error during image cropping: $e");
      return null;
    }
  }

  // 카메라 모듈 UI 빌드
  Widget _buildCameraModule() {
    if (_selectedImage != null) {
      return Image.file(_selectedImage!); // 선택된 이미지 표시
    } else if (widget.imageUrl != null) {
      return Image.network(widget.imageUrl!); // 기존 이미지 URL 표시
    } else {
      return const Center(
        child: Icon(
          Icons.camera_alt,
          size: 30,
          color: Colors.grey,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openCamera, // 카메라 여는 함수
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          // color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Color(0x8049454F), // 기본 테두리 색
            width: 1,
          ),
          image: _selectedImage != null
              ? DecorationImage(
            image: FileImage(_selectedImage!),
            fit: BoxFit.contain,
          )
              : null,
        ),
        child: _buildCameraModule(),
      ),
    );
  }
}
