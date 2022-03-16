import 'package:flutter_test/flutter_test.dart';
import 'package:mine_field_game/models/board.dart';

main() {
  test("Win game", () {
    Board board = Board(
      lines: 2,
      columns: 2,
      quantityBombs: 0,
    );

    board.fields[0].undermine();
    board.fields[3].undermine();

    board.fields[0].toggleMarktion();
    board.fields[3].toggleMarktion();
    board.fields[1].open();
    board.fields[2].open();

    expect(board.solved, isTrue);
  });
}
