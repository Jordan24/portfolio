import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
void main() {
// Tests that 2 + 2 = 4
  test('2 + 2 = 4', () {
    expect(add(2, 2), 4);
  });
  // Tests that 0 + 0 = 0
    test('0 + 0 = 0', () {
      expect(add(0, 0), 0);
    });

  // Tests that -1 + 1 = 0
    test('-1 + 1 = 0', () {
      expect(add(-1, 1), 0);
    });

  // Tests that -2 + -3 = -5
    test('-2 + -3 = -5', () {
      expect(add(-2, -3), -5);
    });

  // Tests that 100 + 200 = 300
    test('100 + 200 = 300', () {
      expect(add(100, 200), 300);
    });

}