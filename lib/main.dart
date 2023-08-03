import 'package:flutter/material.dart';
import 'grid_table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTacToe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'XOX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final Map<String, String> dataMap = {};

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // player 1 and two
  late bool p1, p2;
  Display tab = Display(cellCount: 9);

  late int filledCells;
  late int winner;
  late List<int> winnerCells;

  @override
  initState() {
    start();
    super.initState();
  }

  void nextPlayer() {
    setState(() {
      p2 = p1;
      p1 = !p1;
    });
  }

  void start() {
    setState(() {
      tab.resetTable();
      p1 = true;
      p2 = false;
      filledCells = 0;
      winner = 0;
      winnerCells = [-1, -1, -1];
    });
  }

  // 0 -> none// 1 -> p1 won// 2 -> p2 won
  int checkRows() {
    int x = 0; // Player 2

    int o = 0; //Player 1

    for (final i in [0, 1, 2]) {
      if (tab.grids[i][0] == Player.one) {
        o++;
      } else if (tab.grids[i][0] == Player.two) {
        x++;
      }
    }
    if (x == 3) {
      winnerCells = [0, 1, 2];
      return 2;
    } else if (o == 3) {
      winnerCells = [0, 1, 2];
      return 1;
    }

    x = o = 0;

    for (final i in [3, 4, 5]) {
      if (tab.grids[i][0] == Player.one) {
        o++;
      } else if (tab.grids[i][0] == Player.two) {
        x++;
      }
    }
    if (x == 3) {
      winnerCells = [3, 4, 5];
      return 2;
    } else if (o == 3) {
      winnerCells = [3, 4, 5];
      return 1;
    }

    x = o = 0;

    for (final i in [6, 7, 8]) {
      if (tab.grids[i][0] == Player.one) {
        o++;
      } else if (tab.grids[i][0] == Player.two) {
        x++;
      }
    }
    if (x == 3) {
      winnerCells = [6, 7, 8];
      return 2;
    } else if (o == 3) {
      winnerCells = [6, 7, 8];
      return 1;
    }
    return 0;
  }

  int checkCols() {
    int x = 0; // Player 2

    int o = 0; //Player 1

    for (final i in [0, 3, 6]) {
      if (tab.grids[i][0] == Player.one) {
        o++;
      } else if (tab.grids[i][0] == Player.two) {
        x++;
      }
    }
    if (x == 3 || o == 3) {
      winnerCells = [0, 3, 6];
      return x == 3 ? 2 : 1;
    }

    x = o = 0;

    for (int i in [1, 4, 7]) {
      if (tab.grids[i][0] == Player.one) {
        o++;
      } else if (tab.grids[i][0] == Player.two) {
        x++;
      }
    }
    if (x == 3 || o == 3) {
      winnerCells = [1, 4, 7];
      return x == 3 ? 2 : 1;
    }

    x = o = 0;

    for (int i = 2; i < 9; i += 3) {
      if (tab.grids[i][0] == Player.one) {
        o++;
      } else if (tab.grids[i][0] == Player.two) {
        x++;
      }
    }
    if (x == 3 || o == 3) {
      winnerCells = [2, 5, 8];
      return x == 3 ? 2 : 1;
    }
    return 0;
  }

  int checkCross() {
    int o = 0;
    int x = 0;

    for (int i in [0, 4, 8]) {
      if (tab.grids[i][0] == Player.one) {
        o++;
      } else if (tab.grids[i][0] == Player.two) {
        x++;
      }
    }

    if (x == 3 || o == 3) {
      winnerCells = [0, 4, 8];
      return x == 3 ? 2 : 1;
    }

    x = o = 0;

    for (int i in [2, 4, 6]) {
      if (tab.grids[i][0] == Player.one) {
        o++;
      } else if (tab.grids[i][0] == Player.two) {
        x++;
      }
    }

    if (x == 3 || o == 3) {
      winnerCells = [2, 4, 6];
      return x == 3 ? 2 : 1;
    }
    return 0;
  }

  int checkCondition() {
    int col = checkCols();
    if (col != 0) return col;

    int row = checkRows();
    if (row != 0) return row;

    int cross = checkCross();
    return cross;
  }

  void symbolClicked(int index) {
    bool isClicked = tab.grids[index][1];

    if (!isClicked) {
      tab.grids[index][1] = true;
      tab.grids[index][0] = p1 ? Player.one : Player.two;
      nextPlayer();
      filledCells++;
    }
  }

  Widget laySymbols(int index) {
    Player clickedPlayer = tab.grids[index][0];
    if (winner == 1 && winnerCells.contains(index)) {
      return Image.asset(
        'assets/images/owon.jpg',
      );
    } else if (winner == 2 && winnerCells.contains(index)) {
      return Image.asset(
        'assets/images/xwon.jpg',
      );
    } else if (clickedPlayer == Player.one) {
      return Image.asset(
        'assets/images/o1.jpg',
      );
    } else if (clickedPlayer == Player.two) {
      return Image.asset(
        'assets/images/x2.jpg',
      );
    } else {
      return Container(color: Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (winner == 0) {
                      setState(() {
                        symbolClicked(index);
                        winner = checkCondition();
                      });
                    }
                  },
                  child: Container(
                    //width: 50,
                    //height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 4,
                        color: Colors.blueAccent,
                      ),
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Center(
                      child: laySymbols(index),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.black,
                            height: 50,
                            child: (winner != 0 || filledCells == tab.cellCount)
                                ? FilledButton.tonal(
                                    onPressed: () {
                                      start();
                                    },
                                    child: const Text('New game'),
                                  )
                                : const Text(""),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                            ),
                            border: Border.all(color: Colors.black),
                            color: ((p1 && winner == 0) || (!p1 && winner == 1))
                                ? Colors.green
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          height: 50,
                          child: const ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                            ),
                            child: Text("Player 1"),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                            border: Border.all(color: Colors.black),
                            color: ((p2 &&
                                        winner == 0 &&
                                        filledCells != tab.cellCount) ||
                                    (!p2 && winner == 2))
                                ? Colors.red
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          height: 50,
                          child: const ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                            child: Text("Player 2"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            border: Border.all(color: Colors.black),
                            color: (winner == 1 ||
                                    (winner == 0 &&
                                        filledCells == tab.cellCount))
                                ? Colors.green
                                : Colors.black,
                          ),
                          alignment: Alignment.center,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                            ),
                            child: winner == 1
                                ? const Text("Winner 🥳")
                                : (winner == 0 && filledCells == tab.cellCount
                                    ? const Text("Draw!")
                                    : const Text("")),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            border: Border.all(color: Colors.black),
                            color: (winner == 2 ||
                                    (winner == 0 &&
                                        filledCells == tab.cellCount))
                                ? Colors.red
                                : Colors.black,
                          ),
                          alignment: Alignment.center,
                          height: 50,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            child: winner == 2
                                ? const Text("Winner 🥳")
                                : (winner == 0 && filledCells == tab.cellCount
                                    ? const Text("Draw!")
                                    : const Text("")),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
