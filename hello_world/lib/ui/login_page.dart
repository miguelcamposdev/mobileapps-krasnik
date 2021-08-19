
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/ui/register_page.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleButton =
        ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20));

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                ),
                Container(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'If you do not have an account, ',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Register now!',
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => _goToRegisterPage(context),
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline)),
                    ],
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

  _goToRegisterPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RegisterPage()),
    );
  }
}
