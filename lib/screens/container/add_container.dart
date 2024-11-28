import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/widgets/camera_widget.dart';
import 'package:yiu_aisl_adizzi_app/models/container_items.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/main_button.dart';

class AddContainerPage extends StatefulWidget {
  final Function(ContainerItem) onAdd;
  final ContainerItem? initialItem;

  const AddContainerPage({required this.onAdd, this.initialItem, Key? key})
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
      _controller.text = widget.initialItem!.name;
      _selectedImage = widget.initialItem!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '금쪽이의 방',
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

                    final item = ContainerItem(
                      id: widget.initialItem?.id,
                      name: _controller.text,
                      image: _selectedImage,
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