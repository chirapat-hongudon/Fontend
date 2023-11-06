import 'package:flutter/material.dart';
import 'package:project_mobile_app/menu/game/TicTacToc_page_easy.dart';
import 'package:project_mobile_app/menu/game/TicTacToc_page_hard.dart';
import 'package:project_mobile_app/menu/components/background.dart';

class LevelTicTacTocPage extends StatefulWidget {
  const LevelTicTacTocPage({Key? key}) : super(key: key);

  @override
  State<LevelTicTacTocPage> createState() => _LevelTicTacTocPageState();
}

class _LevelTicTacTocPageState extends State<LevelTicTacTocPage> {
  String selectedLevel = '';

  void navigateToSelectedLevel() {
    if (selectedLevel == 'Easy') {
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => TicTacToeEasyPage(),
            ),
          )
          .then((value) {});
    } else if (selectedLevel == 'Hard') {
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) => TicTacToeHardPage(),
            ),
          )
          .then((value) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Positioned(
              top: 50,
              left: 20,
              child: Text(
                'Tic Tac Toc',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFF5F3FF),
              ),
              child: Image.asset(
                "images/Tic Tac Toe.png",
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tic Tac Toe',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '     รายละเอียดของเกม Tic Tac Toe รายละเอียดของเกม Tic Tac Toe รายละเอียดของเกม Tic Tac Toe',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Level',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFF5F3FF),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedLevel = 'Easy';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: selectedLevel == 'Easy'
                                ? Colors.green
                                : Colors.white,
                            minimumSize: Size(150, 50),
                          ),
                          child: Text(
                            'Easy',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: selectedLevel == 'Easy'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFF5F3FF),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedLevel = 'Hard';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: selectedLevel == 'Hard'
                                ? Colors.red
                                : Colors.white,
                            minimumSize: Size(150, 50),
                          ),
                          child: Text(
                            'Hard',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: selectedLevel == 'Hard'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      navigateToSelectedLevel();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 60),
                    ),
                    child: Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
