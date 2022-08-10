import 'package:flutter/material.dart';

inkButton(BuildContext context) {
  return Tooltip(
    message: 'Voltar',
    child: ClipOval(
      child: Material(
        color: Colors.white, // Button color
        child: InkWell(
          splashColor: Colors.white, // Splash color
          onTap: () {
            Navigator.pop(context);
          },
          child: const SizedBox(
            width: 56,
            height: 56,
            child: Icon(
              Icons.home,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}
