import 'package:flutter/material.dart';

import '../style/style.dart';

class ListContent {

  Widget listFrame(List<Map<String, dynamic>> menuData) {

    return
    ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuData.length,
        // itemBuilder: (context, i) => _cardList(context, i),
        itemBuilder: (context, i) {
          var title =  menuData[i][i].value;
          return null;
        }
      );
  }

  //
  // Widget _cardList(BuildContext context, int i, List<Map<String, dynamic>> menuData)) {
  //   return Card(
  //     child: ListTile(
  //       title: _textTitle(context.),
  //       subtitle: ListView.builder(
  //         itemCount: .length,
  //         itemBuilder: (context, i) => Text('${context.widget}'),
  //       )
  //   );
  // }

  Widget _textTitle(String textTitle) {
    return Text(
      textTitle,
      style: const TextStyle(
          fontSize: 16.0,
          color: Color(0xFFFFF59D),
          fontFamily: BoldFont,
          fontWeight: FontWeight.bold),
    );
  }


}