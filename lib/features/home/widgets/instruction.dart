import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_counter/features/blocs/update_bool_cubit/update_bool_cubit.dart';

class Instruction extends StatelessWidget {
  const Instruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(0, 0, 0, 0.7),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 3,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: RichText(
              text: TextSpan(
                text: "Tap ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
                children: [
                  TextSpan(
                    text: "or ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: "Swipe Up ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: "to increase point",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width / 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/instruction/click.png",
                color: Colors.white,
                scale: 3,
              ),
              Image.asset(
                "assets/instruction/swipe_up.png",
                color: Colors.white,
                scale: 3,
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width / 1.6),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: RichText(
              text: TextSpan(
                text: "Swipe down ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
                children: [
                  TextSpan(
                    text: "to decrease point",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width / 12),
          Image.asset(
            "assets/instruction/swipe_down.png",
            color: Colors.white,
            scale: 3,
          ),
          SizedBox(height: MediaQuery.of(context).size.width / 30),
          InkWell(
            onTap: () {
              context.read<UpdateBoolCubit>().updateBool(false);
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 130,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "OK, I got it!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
