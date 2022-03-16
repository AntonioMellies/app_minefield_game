import 'dart:math';

import 'package:mine_field_game/models/field.dart';

class Board {
  final int lines;
  final int columns;
  final int quantityBombs;

  final List<Field> _fields = [];

  Board({
    required this.lines,
    required this.columns,
    required this.quantityBombs,
  }) {
    _createFields();
    _relateNeighbors();
    _rafflingMines();
  }

  void restart() {
    _fields.forEach((element) => element.reset());
    _rafflingMines();
  }

  void showBombs() {
    _fields.forEach((element) => element.showBomb());
  }

  void _createFields() {
    for (int l = 0; l < lines; l++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(line: l, column: c));
      }
    }
  }

  void _relateNeighbors() {
    for (Field field in _fields) {
      for (Field neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  void _rafflingMines() {
    int raffling = 0;

    if (quantityBombs > (lines * columns)) return;

    while (raffling < quantityBombs) {
      int i = Random().nextInt(_fields.length);

      if (!_fields[i].mined) {
        raffling++;
        _fields[i].undermine();
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get solved {
    return _fields.every((element) => element.solved);
  }
}
