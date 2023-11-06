import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

class SpinningWheelHardPage extends StatefulWidget {
  const SpinningWheelHardPage({Key? key}) : super(key: key);

  @override
  State<SpinningWheelHardPage> createState() => _SpinningWheelHardPageState();
}

class _SpinningWheelHardPageState extends State<SpinningWheelHardPage> {
  final selected = BehaviorSubject<int>();
  int rewards = 0;

  List<int> items = [
    -250,
    300,
    150,
    -400,
    500,
    10000,
    -700,
    -800,
    -1150,
    50,
    1000,
    -2000,
    -500,
    -5000,
    100,
    600,
    750,
    85,
    -350
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
