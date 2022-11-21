import 'package:flutter/material.dart';

//*Widget creado para incluir la descripcion como un widget y poder generarlo
class TextInput extends StatelessWidget {
  final String hintText;
  final double fontSize;
  final TextInputType?
      inputType; //variable para capturar el tipo de dato a introducir
  final TextEditingController controller;
  final int maxLines;

  TextInput(
      {Key? key,
      required this.fontSize,
      required this.hintText,
      required this.inputType,
      required this.controller,
      this.maxLines = 1});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0, left: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        // style: TextStyle(
        //     fontSize: fontSize,
        //     color: Colors.blueGrey,
        //     fontWeight: FontWeight.bold),
        // decoration: InputDecoration(
        //     filled: true,
        //     fillColor: Color(0xFFe5e5e5),
        //     border: InputBorder.none,
        //     hintText: hintText,
        //     enabledBorder: OutlineInputBorder(
        //         borderSide: BorderSide(color: Color(0xFFe5e5e5)),
        //         borderRadius: BorderRadius.all(Radius.circular(9.0))),
        //     focusedBorder: OutlineInputBorder(
        //         borderSide: BorderSide(color: Color(0xFFe5e5e5)),
        //         borderRadius: BorderRadius.all(Radius.circular(9.0)))),
        style: TextStyle(),
        decoration: InputDecoration(
            border: UnderlineInputBorder(),
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFe5e5e5)),
                borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }
}