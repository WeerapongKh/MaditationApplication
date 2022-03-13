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
          shape: const StadiumBorder(),
          onPrimary: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 7),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}
