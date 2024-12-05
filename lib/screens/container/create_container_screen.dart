import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/tree_provider.dart';
import 'package:yiu_aisl_adizzi_app/service/container_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/camera_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';

class CreateContainerScreen extends StatefulWidget {
  final int roomId;

  const CreateContainerScreen({required this.roomId, Key? key})
      : super(key: key);

  @override
  _CreateContainerScreenState createState() => _CreateContainerScreenState();
}

class _CreateContainerScreenState extends State<CreateContainerScreen> {
  final TextEditingController _controller = TextEditingController();
  late int _selectedImage;  //선택한 이미지
  late File _selectedImageFile; // 이미지 파일을 저장할 변수

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final room = Provider.of<TreeProvider>(context).getRoomById(widget.roomId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          room?.title! ?? '방 이름 조회 오류',
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
                    _selectedImageFile = image as File;
                  });
                },
                // initialImage: _selectedImage,
              ),
              const SizedBox(height: 30),
              const Text(
                '수납장 이름',
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
                  onPressed: () async{
                    if (_controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("수납장 이름을 입력해주세요.")),
                      );
                      return;
                    }
                    await createContainer(context, title: _controller.text, roomId: widget.roomId, imageId: _selectedImage);

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