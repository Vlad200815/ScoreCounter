import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              if (counter < 2) {
                return;
              } else {
                setState(() {
                  counter--;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: counter == 1 ? Colors.grey.shade300 : Colors.grey,
                ),
              ),
              child: Icon(
                Icons.remove,
                color: counter == 1 ? Colors.grey[300] : Colors.grey,
                size: 25,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            counter.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () {
              setState(() {
                counter++;
              });
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
