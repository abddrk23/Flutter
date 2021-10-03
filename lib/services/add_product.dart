import 'package:flutter/cupertino.dart';

addNew(
  String text,
  double price,
  Function set,
  List option,
  TextEditingController textCont,
  TextEditingController priceCont,
) {
  if (text.isNotEmpty && price.isNaN) {
    option.add(text);
    textCont.clear();
    textCont.clear();
  }
}
