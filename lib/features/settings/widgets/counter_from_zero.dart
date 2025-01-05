import 'package:flutter/material.dart';

class CounterFromZero extends StatefulWidget {
  const CounterFromZero({
    super.key,
    required this.onIncrementTap,
    required this.onDecrementTap,
    required this.counter,
  });

  final void Function()? onIncrementTap;
  final void Function()? onDecrementTap;
  final int counter;

  @override
  State<CounterFromZero> createState() => _CounterFromZeroState();
}

class _CounterFromZeroState extends State<CounterFromZero> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: widget.onDecrementTap,
            // if (counter < 1) {
            //     return;
            //   } else {
            //     setState(() {
            //       counter--;
            //     });
            //   }
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color:
                      widget.counter == 0 ? Colors.grey.shade300 : Colors.grey,
                ),
              ),
              child: Icon(
                Icons.remove,
                color: widget.counter == 0 ? Colors.grey[300] : Colors.grey,
                size: 25,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Center(
            child: Text(
              widget.counter.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: widget.onIncrementTap,
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
