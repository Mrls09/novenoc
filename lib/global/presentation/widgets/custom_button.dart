import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Acción al presionar el botón
      },
      child: Text('Press Me'),
    );
  }
}
