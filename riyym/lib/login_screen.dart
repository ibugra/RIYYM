import 'package:flutter/material.dart';
import 'package:riyym/dataBase/authentication.dart';
import 'package:riyym/homepage.dart';

import 'forgot_password_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final myController = TextEditingController();
  final myControllerPw = TextEditingController();
  // String username = "name";
  // String password = "123";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('images/RIYYMmusic.png'),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        controller: myController,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                          ),
                          labelText: 'e-mail',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      TextField(
                        controller: myControllerPw,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        autofocus: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.vpn_key,
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.login),
                          TextButton(
                            child: const Text(
                              'login',
                              style: TextStyle(
                                fontFamily: 'Pacifico',
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(primary: Colors.purple),
                            onPressed: () async {
                              var signing = await Authentication().logIn(
                                  myController.text, myControllerPw.text);
                              if (signing == 'true') {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return HomePage();
                                    },
                                  ),
                                  (route) => true,
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(signing),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Don\'t have an account?'),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const RegistrationScreen();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              ' SignUp',
                              style: TextStyle(
                                fontFamily: 'Pacifico',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.pink,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Forgot password?'),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPassword();
                                  },
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              ' Click Here ',
                              style: TextStyle(
                                fontFamily: 'Pacifico',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
