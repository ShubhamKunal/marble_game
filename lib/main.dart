import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marble_game/functions.dart';
import 'package:marble_game/widgets/aesthetic_appbar.dart';
import 'package:marble_game/widgets/custom_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MarbleGameScreen(),
    );
  }
}

class MarbleGameScreen extends StatefulWidget {
  const MarbleGameScreen({super.key});

  @override
  State<MarbleGameScreen> createState() => MarbleGameScreenState();
}

class MarbleGameScreenState extends State<MarbleGameScreen> {
  static const int gridSize = 4;
  int currentPlayer = 1;
  List<List<int?>> board =
      List.generate(gridSize, (_) => List.filled(gridSize, null));
  bool gameEnded = false;

  String player1Name = '';
  String player2Name = '';

  Timer? timer;
  int player1Time = 0;
  int player2Time = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => askPlayerNames());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> askPlayerNames() async {
    String? name1 = await askForName("Enter player 1's name");
    String? name2 = await askForName("Enter player 2's name");

    setState(() {
      player1Name = name1 ?? 'Player 1';
      player2Name = name2 ?? 'Player 2';
    });

    startTimer();
  }

  // Future<String?> askForName(String title) async {
  //   TextEditingController controller = TextEditingController();
  //   return showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: TextField(
  //           controller: controller,
  //           decoration: InputDecoration(hintText: "Enter name"),
  //         ),
  //         actions: [
  //           TextButton(
  //             child: Text("OK"),
  //             onPressed: () {
  //               Navigator.of(context).pop(controller.text.trim());
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<String?> askForName(String title) async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(4, 4),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                TextField(
                  controller: controller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter name",
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(controller.text.trim());
                  },
                  child: Text(
                    "Ready",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (currentPlayer == 1) {
          player1Time++;
        } else {
          player2Time++;
        }
      });
    });
  }

  void placeMarble(int row, int col) {
    if (board[row][col] == null && !gameEnded) {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkWinningCondition(currentPlayer)) {
          gameEnded = true;
          timer?.cancel();
          showWinningDialog(currentPlayer);
        } else {
          rotateMarblesCounterClockwise();
          currentPlayer = currentPlayer == 1 ? 2 : 1;
        }
      });
    }
  }

  void rotateMarblesCounterClockwise() {
    List<List<int?>> newBoard =
        List.generate(gridSize, (_) => List.filled(gridSize, null));

    newBoard[0][0] = board[0][1];
    newBoard[0][1] = board[0][2];
    newBoard[0][2] = board[0][3];
    newBoard[0][3] = board[1][3];
    newBoard[1][3] = board[2][3];
    newBoard[2][3] = board[3][3];
    newBoard[3][3] = board[3][2];
    newBoard[3][2] = board[3][1];
    newBoard[3][1] = board[3][0];
    newBoard[3][0] = board[2][0];
    newBoard[2][0] = board[1][0];
    newBoard[1][0] = board[0][0];

    newBoard[1][1] = board[1][2];
    newBoard[1][2] = board[2][2];
    newBoard[2][2] = board[2][1];
    newBoard[2][1] = board[1][1];

    board = newBoard;
  }

  bool checkWinningCondition(int player) {
    for (int i = 0; i < gridSize; i++) {
      if (board[i].every((cell) => cell == player)) return true;
      if ([for (int j = 0; j < gridSize; j++) board[j][i]]
          .every((cell) => cell == player)) return true;
    }
    if ([for (int i = 0; i < gridSize; i++) board[i][i]]
        .every((cell) => cell == player)) return true;
    if ([for (int i = 0; i < gridSize; i++) board[i][gridSize - i - 1]]
        .every((cell) => cell == player)) return true;
    return false;
  }

  void showWinningDialog(int player) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("${player == 1 ? player1Name : player2Name} wins!"),
        content: Text(
            "Congratulations to ${player == 1 ? player1Name : player2Name}!"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                resetGame();
              });
              Navigator.of(context).pop();
            },
            child: Text("Play Again"),
          )
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      board = List.generate(gridSize, (_) => List.filled(gridSize, null));
      currentPlayer = 1;
      gameEnded = false;
      player1Time = 0;
      player2Time = 0;
    });
    timer?.cancel();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (player1Name.isEmpty || player2Name.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        title: Text(
          'Marble Game',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(2, 2),
                blurRadius: 3,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Functions().themedContainer(
              "${currentPlayer == 1 ? player1Name : player2Name}'s Turn"),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Functions().themedContainerBlueAccent(
                  "$player1Name Time: ${Functions().formatTime(player1Time)}"),
              SizedBox(width: 10),
              Functions().themedContainerPurpleAccent(
                  "$player2Name Time: ${Functions().formatTime(player2Time)}")
            ],
          ),
          AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                int row = index ~/ gridSize;
                int col = index % gridSize;
                return GestureDetector(
                  onTap: () => placeMarble(row, col),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: board[row][col] == null
                          ? Colors.grey[300]
                          : board[row][col] == 1
                              ? Colors.blueAccent
                              : Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  text: "Close"),
              CustomButton(onPressed: resetGame, text: "Reset"),
            ],
          ),
        ],
      ),
    );
  }
}
