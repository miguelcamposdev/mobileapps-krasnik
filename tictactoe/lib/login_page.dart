import 'package:flutter/material.dart';
import 'package:tictactoe/game_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  var showButton;

  @override
  void initState() {
    showButton = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.blue,
            padding: EdgeInsets.all(30),
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Welcome \n to TicTacToe!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.w800)),
                    Container(height: 40),
                    TextFormField(
                      onChanged: (text) => _updateButtonState(text),
                                            controller: nameController,
                                            style: TextStyle(color: Colors.yellow),
                                            cursorColor: Colors.yellow,
                                            decoration: const InputDecoration(
                                              hintText: 'What\'s your name?',
                                              labelText: 'Name *',
                                              labelStyle: TextStyle(color: Colors.yellow),
                                              hintStyle: TextStyle(color: Colors.white),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                borderSide: BorderSide(
                                                  color: Colors.yellow,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          showButton?
                                          Container(
                                              margin: EdgeInsets.only(top: 20),
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () => _startGame(),
                                                child: Text(
                                                  'Start game!',
                                                  style: TextStyle(color: Colors.blue),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(Colors.yellow),
                                                ),
                                              )) : Text('')
                                        ],
                                      ))));
                        }
                      
                        _startGame() {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => GamePage()),
                          );
                        }
                      
                        _updateButtonState(String text) {
                          if(text.isEmpty) {
                            // Hide the button
                            setState(() {
                              showButton = false;
                            });
                          } else {
                            // Show the button
                            setState(() {
                              showButton = true;
                            });
                          }
                        }
}
