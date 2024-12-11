import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/service/image_service.dart';

Future<void> showCreateContainerDialog({
  required BuildContext context,
  required String? imageUrl,
  required Future<File?> Function(File image) onCropImage,
  required Future<File?> Function() onPickFromCamera,
}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '이미지 선택',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        content: const Text(
          '기존 이미지를 수정하시겠습니까,\n새로 촬영하시겠습니까?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // 다이얼로그 닫기
              if (imageUrl != null) {
                final File downloadedImage = await downloadImage(imageUrl);
                await onCropImage(downloadedImage); // 이미지 크롭
              }
            },
            child: const Text(
              '이미지 수정',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // 다이얼로그 닫기
              final File? image = await onPickFromCamera(); // 카메라에서 이미지 선택
              if (image != null) {
                await onCropImage(image); // 이미지 크롭
              }
            },
            child: const Text(
              '카메라 열기',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
