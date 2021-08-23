import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewPlayerPage extends StatefulWidget {
  @override
  _NewPlayerPageState createState() => _NewPlayerPageState();
}

class _NewPlayerPageState extends State<NewPlayerPage> {
  final nameController = TextEditingController();
  final ButtonStyle styleButton =
      ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20));
  CollectionReference players = FirebaseFirestore.instance.collection('players');
  var ratingSelected = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('New player'),
        ),
        body: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(children: [
              TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Write the player name...',
                    labelText: 'Player Name *',
                  )),
              RatingBar(
                initialRating: ratingSelected,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full:
                      SvgPicture.asset('assets/images/ic_soccer_ball_full.svg'),
                  empty: SvgPicture.asset(
                      'assets/images/ic_soccer_ball_empty.svg'),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  ratingSelected = rating;
                },
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: styleButton,
                  onPressed: () => _savePlayer(),
                  child: Text('Save player'),
                ),
              ),
            ])));
  }

  _savePlayer() {
    var name = nameController.text;
    if (name.isNotEmpty) {
     players.add({
            'name': name,
            'rate': ratingSelected
          })
          .then((value) => Navigator.pop(context))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }
}
