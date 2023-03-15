import 'package:flutter/material.dart';
import 'package:riyym/dataBase/firestoredata.dart';
import 'package:riyym/profile/textfield.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Account',
      home: FutureBuilder(
        future: FireStore().getUserInfo(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.red,
                title: const Center(
                  child: Text('My Account'),
                ),
              ),
              body: ListView(
                children: <Widget>[
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.blue,
                        Colors.red,
                      ],
                    )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: const <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white70,
                              minRadius: 60.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.black,
                                ),
                                radius: 50.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data.name + ' ' + snapshot.data.surName,
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          snapshot.data.email,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        TextFieldWidget(
                            label: 'User Mail',
                            text: snapshot.data.email,
                            onChanged: (name) {}),
                        TextFieldWidget(
                            label: 'User Name',
                            text: snapshot.data.name +
                                ' ' +
                                snapshot.data.surName,
                            onChanged: (name) {}),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
