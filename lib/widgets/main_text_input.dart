import 'package:flutter/material.dart';

class MainTextInput extends StatefulWidget {
  final String label;
  final bool showIcon;
  final bool showRequest;
  final bool showCheck;

  const MainTextInput({
    super.key,
    required this.label,
    required this.showIcon,
    required this.showRequest,
    required this.showCheck,
  });

  @override
  _MainTextInputState createState() => _MainTextInputState();
}

class _MainTextInputState extends State<MainTextInput> {
  bool isVisible = true;

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double buttonWidth = width * 0.22;
    double buttonHeight = height * 0.025;
    double padding = width * 0.04;

    return Container(
      margin:  EdgeInsets.only(bottom: width* 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD5D5D5)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: padding),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF595959),
              ),
            ),
          ),
          const Spacer(),
          if (widget.showRequest)
            Padding(
              padding: EdgeInsets.only(right: padding),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6D6D6),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  minimumSize: Size(buttonWidth,buttonHeight),
                ),
                onPressed: () {},
                child: const Text(
                  '인증요청',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF595959),
                  ),
                ),
              ),
            ),
          if (widget.showCheck)
            Padding(
              padding: EdgeInsets.only(right: padding),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6D6D6),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),

                  minimumSize: Size(buttonWidth, buttonHeight),
                ),
                onPressed: () {},
                child: const Text(
                  '인증확인',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF595959),
                  ),
                ),
              ),
            ),
          if (widget.showIcon)
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
    );
  }
}
