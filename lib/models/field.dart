import 'package:mine_field_game/models/exceptionExplosion.dart';

class Field {
  final int line;
  final int column;
  final List<Field> neighbors = [];

  bool _opened = false;
  bool _mined = false;
  bool _marked = false;
  bool _exploded = false;

  Field({required this.line, required this.column});

  void addNeighbor(Field neighbor) {
    final deltaLine = (line - neighbor.line).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaLine == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaLine <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void open() {
    if (_opened) return;

    _opened = true;

    if (_mined) {
      _exploded = true;
      throw ExceptionExplosion();
    }

    if (safeNeighborhood) {
      neighbors.forEach((v) => v.open());
    }
  }

  void showBomb() {
    if (mined) {
      _opened = true;
    }
  }

  void undermine() {
    _mined = true;
  }

  void toggleMarktion() {
    _marked = !_marked;
  }

  void reset() {
    _opened = false;
    _mined = false;
    _marked = false;
    _exploded = false;
  }

  bool get mined {
    return _mined;
  }

  bool get exploded {
    return _exploded;
  }

  bool get opened {
    return _opened;
  }

  bool get marked {
    return _marked;
  }

  bool get solved {
    bool minedAndMarked = mined && marked;
    bool safeAndOpened = !mined && opened;
    return minedAndMarked || safeAndOpened;
  }

  bool get safeNeighborhood {
    return neighbors.every((element) => !element.mined);
  }

  int get quantityMinesInNeighborhood {
    return neighbors.where((element) => element.mined).length;
  }
}
