enum Player { one, two, none }

class Display {
  var grids = [];
  late int cellCount;

  Display({required this.cellCount});

  // Initialized grids -> [[player,isClicked]]
  void resetTable() {
    grids.clear();
    for (int i = 0; i < cellCount; i++) {
      grids.add([Player.none, false]);
    }
  }
}
