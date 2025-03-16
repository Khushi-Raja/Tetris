// grid dimensions
import 'package:flutter/material.dart';

int rowLength = 10;
int colLength = 15;

enum Direction {
  left,
  right,
  down,
}

enum Tetromino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500), // Orange
  Tetromino.J: Color.fromRGBO(255, 0, 102, 1.0), // Pinkish Red
  Tetromino.I: Color.fromRGBO(255, 242, 0, 1.0), // Yellow
  Tetromino.O: Color(0xFF00FFFF), // Yellow (Incorrect format, see below)
  Tetromino.S: Color(0xFF00FF00), // Green
  Tetromino.Z: Color(0xFFFF0000), // Red
  Tetromino.T: Color(0xFF800080), // Orange Variant
};