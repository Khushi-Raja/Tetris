import 'package:flutter/material.dart';
import 'package:tetris_game/values.dart';

class Piece {
  // type of tetris piece
  Tetromino type;

  Piece({required this.type});

  // the piece is just a list of integers
  List<int> position = [];

  // color of tetris piece
  Color get color {
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  // generate the integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26, -16, -6, -5
        ];
        break;
      case Tetromino.J:
        position = [
          -25, -15, -5, -6
        ];
        break;
      case Tetromino.I:
        position = [
          -4, -5, -6, -7
        ];
        break;
      case Tetromino.O:
        position = [
          -15, -16, -5, -6
        ];
        break;
      case Tetromino.S:
        position = [
          -15, -14, -6, -5
        ];
        break;
      case Tetromino.Z:
        position = [
          -17, -16, -6, -5
        ];
        break;
      case Tetromino.T:
        position = [
          -26, -16, -6, -15
        ];
        break;
    }
  }

  // move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for(int i=0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for(int i=0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for(int i=0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  // rotate piece
  int rotationState = 1;
  void rotatePiece() {
    // new position
    List<int> newPosition = [];

    // rotate the piece based on it's type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1
            ];
            // update position
            position = newPosition;
            // update rotation state
            rotationState = (rotationState + 1) % 4;
            break;
          case 1:
            /*
            o o o
            o
            */
          // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1
            ];
            // update position
            position = newPosition;
            // update rotation state
            rotationState = (rotationState + 1) % 4;
            break;
          case 2:
          /*
            o o
              o
              o
            */
          // get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1
            ];
            // update position
            position = newPosition;
            // update rotation state
            rotationState = (rotationState + 1) % 4;
            break;
          case 3:
          /*
                o
            o o o
            */
          // get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1
            ];
            // update position
            position = newPosition;
            // update rotation state
            rotationState = (rotationState + 1) % 4;
            break;
        }
        break;
      case Tetromino.J:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Tetromino.I:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Tetromino.O:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Tetromino.S:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Tetromino.Z:
        // TODO: Handle this case.
        throw UnimplementedError();
      case Tetromino.T:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
