import 'package:flutter/material.dart';

class TabOptionWidget extends StatelessWidget {
  const TabOptionWidget(
      {super.key,
      required this.title,
      this.isActive = false,
      this.isLast = false,
      this.onTap});

  final String title;
  final bool isActive;
  final bool isLast;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isActive ? Colors.grey : Colors.white,
            border: Border(
              bottom: const BorderSide(color: Colors.black),
              top: const BorderSide(color: Colors.black),
              left: const BorderSide(color: Colors.black),
              right: isLast
                  ? const BorderSide(color: Colors.black)
                  : BorderSide.none,
            )),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
