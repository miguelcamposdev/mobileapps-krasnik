import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
  final String gameId;
  final bool isYourTurn;

  GamePage({required this.gameId, required this.isYourTurn});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  /** 
   *   0 | 0 | 0
   *  -----------
   *   0 | 0 | 0
   *  -----------
   *   0 | 0 | 0
   * 
   *  0 > empty
   *  1 > player 1 selected
   *  2 > player 2 selected
  */

  //                         0 1 2 3 4 5 6 7 8
  List<int> selectedCells = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  var yourTurn = false;
  var player1IsPlaying = true;
  var gameOver = false;
  var title = "";
  var playerNumber;
  var p1Name = "";
  var p2Name = "";

  @override
  void initState() {
    yourTurn = widget.isYourTurn;
    if (yourTurn) {
      playerNumber = 1;
    } else {
      playerNumber = 2;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _gameStream = FirebaseFirestore.instance
        .collection('games')
        .doc(widget.gameId)
        .snapshots();

    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
          color: Colors.blue,
          width: double.infinity,
          height: double.infinity,
          child: StreamBuilder<DocumentSnapshot>(
            stream: _gameStream,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              }

              var gameInformation = snapshot.data!;
              Map<String, dynamic> data =
                  gameInformation.data()! as Map<String, dynamic>;
              if (data['player2'] == "") {
                return _widgetGameLoading(data['player1']);
              } else {
                p1Name = data['player1'];
                p2Name = data['player2'];
                for(var i = 0; i<9; i++) {
                  selectedCells[i] = data['cells'][i];
                }
                title = '$p1Name VS $p2Name';
                return _widgetGameDashboard();
              }
            },
          )),
    );
  }

  _widgetGameLoading(String player1Name) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      Text('Hi $player1Name, we are waiting another player. Be patient!',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Container(height: 20),
      CircularProgressIndicator(color: Colors.white)
    ]));
  }

  _widgetGameDashboard() {
    return Column(children: [
      Expanded(
          flex: 1,
          child: Text(title,
              textAlign: TextAlign.center,
              style: GoogleFonts.pressStart2p(
                  textStyle: TextStyle(color: Colors.white, fontSize: 20)))),
      Expanded(
          flex: 3,
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(5), child: _getCellImage(0))),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(5), child: _getCellImage(1))),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(5), child: _getCellImage(2)))
          ])),
      Expanded(
          flex: 3,
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(5), child: _getCellImage(3))),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(5), child: _getCellImage(4))),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(5), child: _getCellImage(5)))
          ])),
      Expanded(
          flex: 3,
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(5), child: _getCellImage(6))),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(5), child: _getCellImage(7))),
            Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.all(5), child: _getCellImage(8)))
          ])),
    ]);
  }

  _getCellImage(int position) {
    var cellValue = selectedCells[position];
    if (cellValue == 0) {
      return GestureDetector(
          onTap: () => !gameOver ? _changeCellValue(position) : null,
          child: SvgPicture.asset('assets/ic_empty_cell.svg'));
    } else if (cellValue == 1) {
      return GestureDetector(
          onTap: () => !gameOver ? _changeCellValue(position) : null,
          child: SvgPicture.asset('assets/ic_player_1.svg'));
    } else if (cellValue == 2) {
      return GestureDetector(
          onTap: () => !gameOver ? _changeCellValue(position) : null,
          child: SvgPicture.asset('assets/ic_player_2.svg'));
    }
  }

  _changeCellValue(int position) {
    setState(() {
      if (selectedCells[position] == 0) {

        if (playerNumber == 1) {
          selectedCells[position] = 1;
        } else {
          selectedCells[position] = 2;
        }

        CollectionReference games = FirebaseFirestore.instance.collection('games');
        games.doc(widget.gameId).set({'cells': selectedCells},
            SetOptions(merge: true)).then((value2) {});

        if (_checkSolution()) {
          _showWinnerDialog();
          gameOver = true;
        } else {
          player1IsPlaying = !player1IsPlaying;
        }
      }
    });
  }

  _checkSolution() {
    var existSolution = false;
    if (selectedCells[0] == selectedCells[3] &&
        selectedCells[3] == selectedCells[6] &&
        selectedCells[6] != 0) {
      existSolution = true;
    } else if (selectedCells[1] == selectedCells[4] &&
        selectedCells[4] == selectedCells[7] &&
        selectedCells[7] != 0) {
      existSolution = true;
    } else if (selectedCells[2] == selectedCells[5] &&
        selectedCells[5] == selectedCells[8] &&
        selectedCells[8] != 0) {
      existSolution = true;
    } else if (selectedCells[0] == selectedCells[1] &&
        selectedCells[1] == selectedCells[2] &&
        selectedCells[2] != 0) {
      existSolution = true;
    } else if (selectedCells[3] == selectedCells[4] &&
        selectedCells[4] == selectedCells[5] &&
        selectedCells[5] != 0) {
      existSolution = true;
    } else if (selectedCells[6] == selectedCells[7] &&
        selectedCells[7] == selectedCells[8] &&
        selectedCells[8] != 0) {
      existSolution = true;
    } else if (selectedCells[0] == selectedCells[4] &&
        selectedCells[4] == selectedCells[8] &&
        selectedCells[8] != 0) {
      existSolution = true;
    } else if (selectedCells[2] == selectedCells[4] &&
        selectedCells[4] == selectedCells[6] &&
        selectedCells[6] != 0) {
      existSolution = true;
    }

    return existSolution;
  }

  Future<void> _showWinnerDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: player1IsPlaying
              ? Text('Player 1 wins!')
              : Text('Player 2 wins!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [SvgPicture.asset('assets/medal.svg', height: 100)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Restart the game'),
              onPressed: () {
                _restartGame();
              },
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    // Reset the variables to initial value: gameOver, selectedCells,...
    gameOver = false;
    player1IsPlaying = true;
    for (var i = 0; i < 9; i++) {
      setState(() {
        selectedCells[i] = 0;
      });
    }

    // Close the dialog
    Navigator.of(context).pop();
  }
}
