import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              //TODO: decreace the counter by 1
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Icon(
                Icons.remove,
                color: Colors.grey,
                size: 25,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "1",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () {
              //TODO: increace the counter
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Icon(
                Icons.add,
                color: Colors.blue,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
