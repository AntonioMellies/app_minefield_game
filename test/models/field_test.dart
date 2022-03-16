import 'package:flutter_test/flutter_test.dart';
import 'package:mine_field_game/models/field.dart';

main() {
  group("Field", () {
    test("Open field with explosion", () {
      Field f = Field(line: 0, column: 0);
      f.undermine();
      expect(f.open, throwsException);
    });

    test("Open field withou explosion", () {
      Field f = Field(line: 0, column: 0);
      f.open();
      expect(f.opened, isTrue);
    });

    test("Add NOT neighbor", () {
      Field f1 = Field(line: 0, column: 0);
      Field f2 = Field(line: 1, column: 3);
      f1.addNeighbor(f2);
      expect(f1.neighbors.isEmpty, isTrue);
    });
    test("Add neighbor", () {
      Field f1 = Field(line: 3, column: 3);
      Field f2 = Field(line: 3, column: 4);
      Field f3 = Field(line: 2, column: 2);
      Field f4 = Field(line: 4, column: 4);

      f1.addNeighbor(f2);
      f1.addNeighbor(f3);
      f1.addNeighbor(f4);

      expect(f1.neighbors.length, 3);
    });

    test("Quantity mines in neighborhood is two", () {
      Field f1 = Field(line: 3, column: 3);
      Field f2 = Field(line: 3, column: 4);
      Field f3 = Field(line: 2, column: 2);
      Field f4 = Field(line: 4, column: 4);

      f2.undermine();
      f3.undermine();
      
      f1.addNeighbor(f2);
      f1.addNeighbor(f3);
      f1.addNeighbor(f4);

      expect(f1.quantityMinesInNeighborhood, 2);
    });
  });
}
