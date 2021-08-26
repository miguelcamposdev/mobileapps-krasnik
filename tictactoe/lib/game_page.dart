import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
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
  var yourTurn = true;
  var player1IsPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
          color: Colors.blue,
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [
            Expanded(
                flex: 1,
                child: Text('Miguel VS Kuba',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pressStart2p(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 20)))),
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
          ])),
    );
  }

  _getCellImage(int position) {
    var cellValue = selectedCells[position];
    if (cellValue == 0) {
      return GestureDetector(
          onTap: () => _changeCellValue(position),
          child: SvgPicture.asset('assets/ic_empty_cell.svg'));
    } else if (cellValue == 1) {
      return GestureDetector(
          onTap: () => _changeCellValue(position),
          child: SvgPicture.asset('assets/ic_player_1.svg'));
    } else if (cellValue == 2) {
      return GestureDetector(
          onTap: () => _changeCellValue(position),
          child: SvgPicture.asset('assets/ic_player_2.svg'));
    }
  }

  _changeCellValue(int position) {
    setState(() {
      if(selectedCells[position] == 0) {
        if (player1IsPlaying) {
          selectedCells[position] = 1;
        } else {
          selectedCells[position] = 2;
        }
        player1IsPlaying = !player1IsPlaying;
      }
    });
  }
}
