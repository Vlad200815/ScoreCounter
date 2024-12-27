import 'package:flutter/material.dart';
import 'package:score_counter/widget/counter.dart';

class Field extends StatelessWidget {
  const Field({
    super.key,
    required this.icon,
    required this.text,
    required this.widget,
  });
  final Widget widget;
  final Widget? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: icon,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            widget
          ],
        ),
      ),
    );
  }
}
