import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project_mobile_app/utils.dart';

class TicTacToeEasyPage extends StatefulWidget {
  const TicTacToeEasyPage({Key? key}) : super(key: key);

  @override
  State<TicTacToeEasyPage> createState() => _TicTacToeEasyPageState();
}

class Player {
  static const none = '';
  static const X = 'X';
  static const O = 'O';
}

class _TicTacToeEasyPageState extends State<TicTacToeEasyPage> {
  static final countMatrix = 3;
  static final double size = 92;

  String lastMove = Player.none;
  late List<List<String>> matrix;

  @override
  void initState() {
    super.initState();
    setEmptyFields();
  }

  void setEmptyFields() => setState(() => matrix = List.generate(
        countMatrix,
        (_) => List.generate(countMatrix, (_) => Player.none),
      ));

  Color getBackgroundColor() {
    final thisMove = lastMove == Player.X ? Player.O : Player.X;
    return getFieldColor(thisMove).withAlpha(150);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: getBackgroundColor(),
        appBar: AppBar(
          title: Text(
            'Tic Tac Toe Easy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
        ),
      );

  Widget buildRow(int x) {
    final values = matrix[x];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(
        values,
        (y, value) => buildField(x, y),
      ),
    );
  }

  Color getFieldColor(String value) {
    switch (value) {
      case Player.O:
        return Colors.blue;
      case Player.X:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  Widget buildField(int x, int y) {
    final value = matrix[x][y];
    final color = getFieldColor(value);

    return Container(
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size, size),
          primary: color,
        ),
        child: Text(value, style: TextStyle(fontSize: 32)),
        onPressed: () => selectField(value, x, y),
      ),
    );
  }

  void selectField(String value, int x, int y) {
    if (value == Player.none) {
      final newValue = Player.X;

      setState(() {
        lastMove = newValue;
        matrix[x][y] = newValue;
      });

      if (isWinner(x, y)) {
        showEndDialog('You Won');
      } else if (isEnd()) {
        showEndDialog('It\'s a Draw');
      } else {
        makeBotMove();
      }
    }
  }

  bool isEnd() =>
      matrix.every((values) => values.every((value) => value != Player.none));

  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = matrix[x][y];
    final n = countMatrix;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  Future showEndDialog(String title) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text('Press to Restart the Game'),
          actions: [
            ElevatedButton(
              onPressed: () {
                setEmptyFields();
                Navigator.of(context).pop();
              },
              child: Text('Restart'),
            )
          ],
        ),
      );

  void makeBotMove() {
    final emptyCells = [];
    for (int i = 0; i < countMatrix; i++) {
      for (int j = 0; j < countMatrix; j++) {
        if (matrix[i][j] == Player.none) {
          emptyCells.add([i, j]);
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      final randomCell = emptyCells[Random().nextInt(emptyCells.length)];
      final botMoveX = randomCell[0];
      final botMoveY = randomCell[1];

      setState(() {
        lastMove = Player.O;
        matrix[botMoveX][botMoveY] = Player.O;
      });

      if (isWinner(botMoveX, botMoveY)) {
        showEndDialog('Bot Won');
      } else if (isEnd()) {
        showEndDialog('It\'s a Draw');
      }
    }
  }
}
