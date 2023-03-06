import 'package:flutter/material.dart';




abstract class TextStyles {
  static const TextStyle textHeader = TextStyle(
      fontSize: 25,
      color: Colors.black,
      fontFamily: "Mulish",
      fontWeight: FontWeight.bold
  );

  static const TextStyle textButton = TextStyle(
      fontSize: 20,
      fontFamily: "Mulish",
      fontWeight: FontWeight.bold
  );

  static const TextStyle textAddress = TextStyle(
      color: Colors.orange,
      fontSize: 20,
      fontFamily: "Mulish",
      fontWeight: FontWeight.bold
  );

}

abstract class ButtonStyles {
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(150, 50),
      backgroundColor: Colors.orange,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    )
  );

}