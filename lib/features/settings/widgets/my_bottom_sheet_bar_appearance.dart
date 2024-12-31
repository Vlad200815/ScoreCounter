import 'package:flutter/material.dart';
import 'widgets.dart';

class MyBottomSheetBarAppearance extends StatefulWidget {
  const MyBottomSheetBarAppearance({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  State<MyBottomSheetBarAppearance> createState() => _MyBottomSheetBarState();
}

class _MyBottomSheetBarState extends State<MyBottomSheetBarAppearance> {
  int chooseIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<List<Color>> colors = [
      [Colors.lightBlue, Colors.redAccent],
      [Colors.cyan, Colors.greenAccent],
      [Colors.black, Colors.orange],
      [Colors.lime, const Color.fromARGB(255, 59, 111, 61)],
      [Colors.pink, Colors.deepPurple],
      [Colors.deepOrange, Colors.cyanAccent],
    ];
    return InkWell(
      onTap: () async {
        int? selectedIndex = await showModalBottomSheet<int>(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            int tempIndex = chooseIndex;
            return StatefulBuilder(
              builder: (context, setModalState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        16,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, tempIndex);
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Back",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setModalState(() {
                                        tempIndex = index;
                                      });
                                      print("=========" +
                                          chooseIndex.toString() +
                                          "=================");
                                    },
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 9,
                                            horizontal: 18,
                                          ),
                                          child: ChooseBox(
                                            firstColor: colors[index][0],
                                            secondColor: colors[index][1],
                                          ),
                                        ),
                                        tempIndex == index
                                            ? Positioned(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.33,
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    color: Colors.white,
                                                  ),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  );
                                },
                                childCount: colors.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                );
              },
            );
          },
        );
        if (selectedIndex != null) {
          setState(() {
            chooseIndex = selectedIndex;
          });
          print(">>>>>>>>>>>>>>>>>>>Selected Index ==== $selectedIndex");
        }
      },
      child: widget.child,
    );
  }
}
