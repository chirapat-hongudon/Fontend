import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

class SpinningWheelEasyPage extends StatefulWidget {
  const SpinningWheelEasyPage({Key? key}) : super(key: key);

  @override
  State<SpinningWheelEasyPage> createState() => _SpinningWheelEasyPageState();
}

class _SpinningWheelEasyPageState extends State<SpinningWheelEasyPage> {
  final selected = BehaviorSubject<int>();
  int rewards = 0;

  List<int> items = [
    -50,
    100,
    200,
    -300,
    500,
    -700,
    1000,
    2000,
  ];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spinning Wheel',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: FortuneWheel(
                selected: selected.stream,
                animateFirst: false,
                items: [
                  for (int i = 0; i < items.length; i++) ...<FortuneItem>{
                    FortuneItem(child: Text(items[i].toString())),
                  },
                ],
                onAnimationEnd: () {
                  setState(() {
                    rewards = items[selected.value];
                  });
                  print(rewards);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "You just won " + rewards.toString() + " Points!"),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected.add(Fortune.randomInt(0, items.length));
                });
              },
              child: Container(
                height: 40,
                width: 120,
                color: Colors.redAccent,
                child: Center(
                  child: Text("SPIN"),
                ),
              ),
            ),
            SizedBox(height: 125),
          ],
        ),
      ),
    );
  }
}
