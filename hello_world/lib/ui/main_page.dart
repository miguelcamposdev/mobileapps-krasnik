import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/edit_player_page.dart';
import 'package:hello_world/ui/login_page.dart';
import 'package:hello_world/ui/new_player_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Widget> _widgetPages;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> _playersStream;

  _doLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _playersStream = firestore.collection('players').snapshots();
    _widgetPages = <Widget>[
      _playersListWidget(),
      Text(
        'List of football teams',
      ),
      Container(
          child: ElevatedButton(
              onPressed: () => _doLogout(), child: Text('Logout'))),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('SoccerApp'),
      ),
      body: Center(
        child: _widgetPages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.recent_actors_outlined,
            ),
            label: 'Players',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_police_outlined,
            ),
            label: 'Teams',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  _playersListWidget() {
    return StreamBuilder<QuerySnapshot>(
      stream: _playersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Container(
            width: double.infinity,
            child: Column(children: [
              Expanded(flex: 5, child:
              ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return Row(children: [
                    data['photo'] != null
                        ? SizedBox(
                            width: 100,
                            child: Image(image: NetworkImage(data['photo'])),
                          )
                        : Icon(Icons.camera, size: 100),
                    Column(children: [
                      Text(data['name']),
                      Text('Rate: ${data['rate']}')
                    ]),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                            onTap: () => _navigateToEditPlayer(document.id),
                            child: Icon(Icons.edit)))
                  ]);
                }).toList(),
              )),
              Expanded(flex: 1, child:
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.add),
              ))
            ]));
      },
    );
  }

  _navigateToEditPlayer(String id) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => EditPlayerPage(playerId: id)),
      );
    });
  }
}
