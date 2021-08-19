import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();

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
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.supervised_user_circle),
                    hintText: 'Write your first name...',
                    labelText: 'First name *',
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
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.supervised_user_circle),
                    hintText: 'Write your last name...',
                    labelText: 'Last name *',
                  ),
                  onSaved: (String value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String value) {
                    return (value != null)
                        ? 'Do not use the @ char.'
                        : null;
                  },
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
                    return (value != null)
                        ? 'Password is empty'
                        : null;
                  },
                ),
                TextFormField(
                  controller: passwordRepeatController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Confirm your password...',
                    labelText: 'Repeat Password *',
                  ),
                  onSaved: (String value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (String value) {
                    return (value != null)
                        ? 'The password is empty'
                        : null;
                  },
                ),
                Container(height: 50),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: styleButton,
                    onPressed: () => _doRegister(),
                    child: Text('Register'),
                  ),
                )
              ],
            )));
  }

  _doRegister() {}
}
