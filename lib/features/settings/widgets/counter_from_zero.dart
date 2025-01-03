import 'package:flutter/material.dart';

class CounterFromZero extends StatefulWidget {
  const CounterFromZero({
    super.key,
  });

  @override
  State<CounterFromZero> createState() => _CounterFromZeroState();
}

class _CounterFromZeroState extends State<CounterFromZero> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              if (counter < 1) {
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
                  color: counter == 0 ? Colors.grey.shade300 : Colors.grey,
                ),
              ),
              child: Icon(
                Icons.remove,
                color: counter == 0 ? Colors.grey[300] : Colors.grey,
                size: 25,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 30,
            width: 10,
            child: Text(
              counter.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
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
