import 'dart:math';

class UnknownShape implements Exception {
  final String msg;
  const UnknownShape(this.msg);

  @override
  String toString() => 'UnknownShape: $msg';
}

abstract class ShapeArea {
  ShapeArea();

  double area(String shape);
}

main(List<String> arguments) {
  if (arguments.isNotEmpty) {
    final arg = arguments.first;
    final resolver = ShapeAreaResolver()
      ..add('circle', CircleArea())
      ..add('Rectangle', RectangleArea())
      ..add('tRiangle', RightTriangleArea())
      ..add('SquaRe', SquareArea());

    print(resolver.resolve(arg));
  }
}

class CircleArea extends ShapeArea {
  @override
  double area(String shape) {
    final args = shape.split(',');
    if (args.length == 2) {
      final radiusText = args.last;
      final radius = double.tryParse(radiusText);
      if (radius != null) {
        return pi * radius * radius;
      } else {
        throw Exception('Null Radius');
      }
    } else {
      throw Exception('Args length should be 2');
    }
  }
}

class SquareArea extends ShapeArea {
  @override
  double area(String shape) {
    final args = shape.split(',');
    if (args.length == 2) {
      final sideText = args.last;
      final side = double.tryParse(sideText);
      if (side != null) {
        return side * side;
      } else {
        throw Exception('Null side');
      }
    } else {
      throw Exception('Args length should be 2');
    }
  }
}

class RectangleArea extends ShapeArea {
  @override
  double area(String shape) {
    final args = shape.split(',');
    if (args.length == 3) {
      final sideAText = args[1];
      final sideA = double.tryParse(sideAText);

      final sideBText = args[2];
      final sideB = double.tryParse(sideBText);
      if (sideA != null && sideB != null) {
        return sideA * sideB;
      } else {
        throw Exception('Null sideA or sideB');
      }
    } else {
      throw Exception('Args length should be 3');
    }
  }
}

class RightTriangleArea extends ShapeArea {
  @override
  double area(String shape) {
    final args = shape.split(',');
    if (args.length == 4) {
      final sideAText = args[1];
      final sideA = double.tryParse(sideAText);

      final sideBText = args[2];
      final sideB = double.tryParse(sideBText);

      final sideCText = args[3];
      final sideC = double.tryParse(sideCText);

      if (sideA != null && sideB != null && sideC != null) {
        final biggest = max(max(sideA, sideB), sideC);
        final sides = [sideA, sideB, sideC];
        sides.remove(biggest);
        return (sides[0] * sides[1]) / 2;
      } else {
        throw Exception('Null sideA, sideB or sideC');
      }
    } else {
      throw Exception('Args length should be 4');
    }
  }
}

class ShapeAreaResolver {
  final Map<String, ShapeArea> _resolvers = {};

  ShapeAreaResolver add(String key, ShapeArea shape) {
    _resolvers[key] = shape;
    return this;
  }

  double resolve(String shape) {
    final args = shape.split(',');
    if (args.isNotEmpty) {
      final key = args.first;
      if (_resolvers.containsKey(key)) {
        final r = _resolvers[key];
        if (r != null) {
          return r.area(shape);
        } else {
          throw Exception('null ShapeArea');
        }
      } else {
        throw UnknownShape('ShapeArea key not registered in the ShapeAreaResolver');
      }
    } else {
      throw Exception('empty shape args');
    }
  }
}
