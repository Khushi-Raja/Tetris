import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris_game/piece.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/values.dart';

/*
Game Board

This is a 2x2 grid with null representing empty space.
A non-empty space will have color to represent the landed pieces
*/

// create game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // current tetris piece
  Piece currentPiece = Piece(type: Tetromino.J);

  @override
  void initState() {
    super.initState();

    // start game when app starts
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 800);
    gameLoop(frameRate);
  }

  // game loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // check  landing
        checkLanding();

        // move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  // check for collision in a future position
  // return true -> there is a collision
  // return false -> there is no collision
  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // **Check if out of bounds**
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }

      // **Check if position is already occupied**
      if (row >= 0 && col >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    return false;
  }

  // check landing
  void checkLanding() {
    // if  going down is occupied
    if (checkCollision(Direction.down)) {
      // mark position as occupied on the gameBoard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = (currentPiece.position[i] % rowLength);
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // once landed, create the next piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    // create a random object to generate random tetromino types
    Random rand = Random();

    //  create a new piece with random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
  }

  // move left
  void moveLeft() {
    // make sure the move is valid before we moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // move right
  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // rotate
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * colLength,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowLength,
              ),
              itemBuilder: (context, index) {
                // get row and col of each index
                int row = (index / rowLength).floor();
                int col = (index % rowLength);
                // current piece
                if (currentPiece.position.contains(index)) {
                  return Pixel(color: currentPiece.color, child: index);
                }

                // landed pieces
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                      color: tetrominoColors[tetrominoType], child: '');
                }

                // blank pixel
                else {
                  return Pixel(color: Colors.grey[900], child: index);
                }
              },
            ),
          ),

          // Game CONTROLS
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // left
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                // rotate
                IconButton(
                  onPressed: rotatePiece,
                  color: Colors.white,
                  icon: Icon(Icons.rotate_right),
                ),
                // right
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
