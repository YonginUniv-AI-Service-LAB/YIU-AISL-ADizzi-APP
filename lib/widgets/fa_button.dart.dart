import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/widgets/add_dialog.dart';

class FAButton extends StatelessWidget {
  const FAButton({super.key});




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.05, // 화면 높이의 5%
        right: MediaQuery.of(context).size.width * 0.05,  // 화면 너비의 5%
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3, // 화면 너비의 20%
        height: MediaQuery.of(context).size.height * 0.05, // 화면 높이의 10%
        decoration: BoxDecoration(
          color:  const Color(0xFF5DDA6F),
          borderRadius: BorderRadius.circular(50),
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.white, size: 30),
          onPressed: (){
            showDialog(
              context: context,
              builder: (BuildContext context){
                return const AddDialog();
              },
            );

          }
        ),
      ),
    );
  }
}
