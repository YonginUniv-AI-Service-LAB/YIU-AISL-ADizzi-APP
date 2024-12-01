import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/widgets/camera_widget.dart';
import 'package:yiu_aisl_adizzi_app/models/container_items.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';

class AddContainerPage extends StatefulWidget {
  final Function(ContainerModel) onAdd;
  final ContainerModel? initialItem;
  final String roomName; // 방 이름을 저장하는 변수

  const AddContainerPage({required this.onAdd, this.initialItem, required this.roomName, Key? key})
      : super(key: key);

  @override
  _AddContainerPageState createState() => _AddContainerPageState();
}

class _AddContainerPageState extends State<AddContainerPage> {
  final TextEditingController _controller = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.initialItem != null) {
      _controller.text = widget.initialItem!.title;
      _selectedImage = widget.initialItem!.imageId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.roomName,
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
                  onPressed: () {
                    if (_controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("수납장 이름을 입력해주세요.")),
                      );
                      return;
                    }

                    final item = ContainerModel(
                      containerId: widget.initialItem?.containerId,
                      title: _controller.text,
                      imageId: _selectedImage,
                    );

                    widget.onAdd(item);
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