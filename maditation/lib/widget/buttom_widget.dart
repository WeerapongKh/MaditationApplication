import 'package:flutter/material.dart';

class ButtomWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtomWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.pink.shade100,
          shape: const StadiumBorder(),
          onPrimary: Color.fromARGB(255, 0, 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 7),
        ),
        child: Text(
          text,
          style: TextStyle(fontFamily: 'NotoSans'),
        ),
        onPressed: onClicked,
      );
}
