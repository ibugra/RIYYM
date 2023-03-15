import 'package:flutter/material.dart';

class NotWorking extends StatelessWidget {
  const NotWorking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          const Expanded(
            child: Text(
              "Will be included in part C 😎",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Stack(
            children: [
              Image.asset("images/loading.png"),
            ],
          ),
          const Expanded(child: Text("")),
        ],
      ),
    );
  }
}
