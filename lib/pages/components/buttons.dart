import 'package:flutter/material.dart';

class CertButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonText;

  const CertButton(
      {Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          child: Text(
            this.buttonText,
            style: TextStyle(fontSize: 16),
          ),
          onPressed: this.onPressed,
        ),
      ),
    );
  }
}
