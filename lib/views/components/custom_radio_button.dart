import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({Key? key}) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  int? _selectedValueIndex;
  List<String> buttonText = [' 男 性 ', ' 女 性 ', 'その他', '無回答'];

  Widget button({required String text, required int index}) {
    return InkWell(
      splashColor: Colors.cyanAccent,
      onTap: () {
        setState(() {
          _selectedValueIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFB0B0B0)),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: index == _selectedValueIndex ? Color(0xFFFFF59D) : Color(0xFF565656),
            child: Text(
              text,
              style: TextStyle(
                color: index == _selectedValueIndex ? Color(0xFF424242) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF565656),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('性別'),
          ),
          ...List.generate(
            buttonText.length,
                (index) => button(
              index: index,
              text: buttonText[index],
            ),
          ),
        ],
      ),
    );
  }
}