import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
            child: Column(
          children: [
            Image(
              width: 100,
              image: AssetImage('assets/images/ic_logo.png'),
            ),
            Text(
              'soccerapp'.toUpperCase(),
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.orange,
                  fontWeight: FontWeight.w800),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Write your email...',
                labelText: 'Email *',
              ),
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            )
          ],
        )));
  }
}
