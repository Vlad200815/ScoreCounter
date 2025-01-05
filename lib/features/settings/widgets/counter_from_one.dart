import 'package:flutter/material.dart';

class CounterFromOne extends StatefulWidget {
  const CounterFromOne({
    super.key,
    required this.onIncrementTap,
    required this.onDecrementTap,
    required this.counter,
  });

  final void Function() onIncrementTap;
  final void Function() onDecrementTap;
  final int counter;

  @override
  State<CounterFromOne> createState() => _CounterFromOneState();
}

class _CounterFromOneState extends State<CounterFromOne> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: widget.onDecrementTap,
            // if (counter < 2) {
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
                      widget.counter == 1 ? Colors.grey.shade300 : Colors.grey,
                ),
              ),
              child: Icon(
                Icons.remove,
                color: widget.counter == 1 ? Colors.grey[300] : Colors.grey,
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
