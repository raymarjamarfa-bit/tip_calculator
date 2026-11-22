
import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  test('computes 15 percent tip correctly', () {
    final result = computeTip(500, 15);

    expect(result.tip, 75);
    expect(result.total, 575);
  });
}
