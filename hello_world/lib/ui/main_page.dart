import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/login_page.dart';

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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
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

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Image(image: NetworkImage(data['photo'])),
                ),
                Text(data['name'])
              ]);
          }).toList(),
        );
      },
    );
  }
}
