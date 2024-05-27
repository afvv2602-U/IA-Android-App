import 'package:flutter/material.dart';

class SocialWhiteMediaButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;

  SocialWhiteMediaButton({required this.iconPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50, // Puedes ajustar el tamaño según tus necesidades
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2), // Cambia la posición de la sombra si es necesario
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            width: 30, // Puedes ajustar el tamaño del icono según tus necesidades
            height: 30,
          ),
        ),
      ),
    );
  }
}

