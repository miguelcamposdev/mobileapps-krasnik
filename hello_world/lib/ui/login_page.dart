import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleButton =
        ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20));


    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Container(height: 100),
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
                  controller: emailController,
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
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Write your password...',
                    labelText: 'Password *',
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
                ),
                Container(height: 50),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: styleButton,
                    onPressed: () => _doLogin(),
                    child: Text('Login'),
                  ),
                )
              ],
            )));
  }

  _doLogin() {
    var emailValue = emailController.text;
    var passwordValue = passwordController.text;
    print('Email: $emailValue - Pass: $passwordValue');
  }
}
