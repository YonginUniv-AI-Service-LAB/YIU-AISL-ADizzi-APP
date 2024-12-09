import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/tree_provider.dart';
import 'package:yiu_aisl_adizzi_app/service/container_service.dart';
import 'package:yiu_aisl_adizzi_app/service/image_service.dart';
import 'package:yiu_aisl_adizzi_app/service/slot_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/camera_widget.dart';
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
  File? _selectedImage;  //선택한 이미지

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.container.title!,
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
                // initialImage: _selectedImage,
                // imageUrl: widget.container.imageUrl,
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
                  onPressed: () async{
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

                    await createSlot(context, containerId: widget.container.containerId,
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
