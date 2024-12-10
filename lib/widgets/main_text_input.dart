import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainTextInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final Widget? child;

  const MainTextInput({
    super.key,
    required this.label,
    required this.controller,
    this.child,
  });

  @override
  _MainTextInputState createState() => _MainTextInputState();
}

class _MainTextInputState extends State<MainTextInput> {
  bool isVisible = true;

  @override
  void initState() {
    isVisible = widget.child == null ? true : false;
    super.initState();
  }

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    double buttonWidth = width * 0.22;
    double padding = width * 0.04;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height * 0.055,
          margin: EdgeInsets.only(bottom: width * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD5D5D5)),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: padding),
                  child: TextField(
                    controller: widget.controller,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      hintText: widget.label, // hintText로 레이블 대체
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF595959),
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              widget.child ??
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: IconButton(
                    onPressed: toggleVisibility,
                    icon: isVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}