import 'package:flutter/material.dart';

class SlotAddButton extends StatefulWidget {
  final VoidCallback onAddShelf;
  final VoidCallback onAddItem;
  final IconData icon; // 아이콘 매개변수
  final Color backgroundColor; // 메인 버튼 배경 색상
  final Color shelfButtonColor; // '수납칸 추가' 버튼 배경 색상
  final Color itemButtonColor; // '물건 추가' 버튼 배경 색상
  final Color iconColor; // 아이콘 색상
  final Color textColor;

  const SlotAddButton({
    Key? key,
    required this.onAddShelf,
    required this.onAddItem,
    this.icon = Icons.add, // 기본 아이콘은 'add'
    this.backgroundColor = const Color(0xFF5DDA6F), // 기본 색상
    this.shelfButtonColor = const Color(0x80D6D6D6), // '수납칸 추가' 버튼 기본 색상
    this.itemButtonColor = const Color(0x80D6D6D6), // '물건 추가' 버튼 기본 색상
    this.iconColor = Colors.white, // 아이콘 색상 기본값: 흰색
    this.textColor = const Color(0xFF595959),
  }) : super(key: key);

  @override
  _SlotAddButtonState createState() => _SlotAddButtonState();
}

class _SlotAddButtonState extends State<SlotAddButton> {
  bool _showFloatingButtons = false; // 플로팅 버튼을 눌렀을 때 나타날 버튼들의 상태

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // 첫 번째 추가 버튼 ('수납칸 추가')
        Visibility(
          visible: _showFloatingButtons,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 65.0), // 플로팅 버튼 위에 위치
            child: FloatingActionButton.extended(
              heroTag: 'add_shelf',
              onPressed: widget.onAddShelf,
              icon: Icon(widget.icon, color: Color(0xFF595959)), // 아이콘 변경
              label: Text(
                "수납칸 추가",
                style: TextStyle(color: widget.textColor), // 텍스트 색상 설정
              ),
              backgroundColor: widget.shelfButtonColor, // 색상 변경
              elevation: 0, // 그림자 제거
            ),
          ),
        ),

        // 두 번째 추가 버튼 ('물건 추가')
        Visibility(
          visible: _showFloatingButtons,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 130.0), // '수납칸 추가' 위에 위치
            child: FloatingActionButton.extended(
              heroTag: 'add_item',
              onPressed: widget.onAddItem,
              icon: Icon(widget.icon, color: Color(0xFF595959)), // 아이콘 변경
              label: Text(
                "물건 추가",
                style: TextStyle(color: widget.textColor), // 텍스트 색상 설정
              ),
              backgroundColor: widget.itemButtonColor, // 색상 변경
              elevation: 0, // 그림자 제거
            ),
          ),
        ),

        // 메인 플로팅 버튼
        FloatingActionButton(
          heroTag: 'main_button',
          onPressed: () {
            // 버튼 토글
            setState(() {
              _showFloatingButtons = !_showFloatingButtons;
            });
          },
          child: Icon(_showFloatingButtons ? Icons.close : widget.icon, color: Colors.white), // 아이콘 변경


          backgroundColor: widget.backgroundColor, // 색상 변경
        ),
      ],
    );
  }
}
