import 'package:flutter/material.dart';
import 'package:mine_field_game/components/board.widget.dart';
import 'package:mine_field_game/components/result.widget.dart';
import 'package:mine_field_game/models/board.dart';
import 'package:mine_field_game/models/exceptionExplosion.dart';
import 'package:mine_field_game/models/field.dart';

class MinefieldApp extends StatefulWidget {
  const MinefieldApp({Key? key}) : super(key: key);

  @override
  State<MinefieldApp> createState() => _MinefieldAppState();
}

class _MinefieldAppState extends State<MinefieldApp> {
  bool? _won;
  Board? _board;

  void _restart() {
    setState(() {
      _won = null;
      _board!.restart();
    });
  }

  void _onOpen(Field f) {
    setState(() {
      if (_won != null) return;

      try {
        f.open();
        if (_board!.solved) {
          _won = true;
        }
      } on ExceptionExplosion {
        _won = false;
        _board!.showBombs();
      }
    });
  }

  void _onToogleMarking(Field f) {
    setState(() {
      if (_won != null) return;

      f.toggleMarktion();
      if (_board!.solved) {
        _won = true;
      }
    });
  }

  Board _gerBoard(double width, double height) {
    if (_board == null) {
      int quantityColumns = 15;
      double sizeBoard = width / quantityColumns;
      int quantityLines = (height / sizeBoard).floor();
      _board = Board(lines: quantityLines, columns: quantityColumns, quantityBombs: 30);
    }
    return _board!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: ResultWidget(won: _won, onRestart: _restart),
      body: Container(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BoardWidget(
              board: _gerBoard(constraints.maxWidth, constraints.maxHeight),
              onOpen: _onOpen,
              onToogleMarKing: _onToogleMarking,
            );
          },
        ),
      ),
    ));
  }
}
