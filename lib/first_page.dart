import 'package:eng/home_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('Welcome to',
                      style: TextStyle(fontSize: 36, color: Colors.white))),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'English',
                  style: TextStyle(fontSize: 90, color: Color(0x333232FF)),
                ),
                Text(
                  'Quotes"',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                  textAlign: TextAlign.right,
                )
              ],
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: RawMaterialButton(
                fillColor: Colors.white,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.keyboard_arrow_right,
                  size: 50,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false);
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
