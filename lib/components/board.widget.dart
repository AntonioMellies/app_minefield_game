import 'package:flutter/material.dart';
import 'package:mine_field_game/components/field.widget.dart';
import 'package:mine_field_game/models/board.dart';
import 'package:mine_field_game/models/field.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onToogleMarKing;

  const BoardWidget({
    required this.board,
    required this.onOpen,
    required this.onToogleMarKing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((f) {
          return FieldWidget(
            field: f,
            onOpen: onOpen,
            onToogleMarKing: onToogleMarKing,
          );
        }).toList(),
      ),
    );
  }
}
