import 'package:flutter/material.dart';

class LoginWith extends StatelessWidget {
  final Function loginWith;
  final String text;
  final Image;

  const LoginWith(
      {super.key,
      required this.loginWith,
      required this.text,
      required this.Image,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loginWith(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E5E5),
          border: Border.all(color: Color(0xFF9098B1)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image,
            SizedBox(
              width: 22,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
