import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/tree_provider.dart';
import 'package:yiu_aisl_adizzi_app/service/container_service.dart';
import 'package:yiu_aisl_adizzi_app/service/image_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/camera_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';

class EditContainerScreen extends StatefulWidget {
  final ContainerModel container;

  const EditContainerScreen({required this.container, Key? key})
      : super(key: key);

  @override
  _EditContainerScreenState createState() => _EditContainerScreenState();
}

class _EditContainerScreenState extends State<EditContainerScreen> {
  final TextEditingController _controller = TextEditingController();
  File? _selectedImage;  //선택한 이미지

  @override
  void initState() {
    super.initState();
    _controller.text = widget.container.title!;
    Provider.of<TreeProvider>(context, listen: false).fetchTree(context);
  }

  @override
  Widget build(BuildContext context) {
    final room = Provider.of<TreeProvider>(context).getRoomByContainerId(widget.container.containerId);

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
                    _selectedImage = image;
                  });
                },
                initialImage: _selectedImage,
                imageUrl: widget.container.imageUrl,
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
                    int? imageId = _selectedImage == null ? null : await uploadImage(_selectedImage!.path);

                    await editContainer(context, containerId: widget.container.containerId,
                      title: _controller.text == widget.container.title ? null : _controller.text,
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