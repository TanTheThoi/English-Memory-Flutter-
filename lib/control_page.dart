import 'package:eng/home_page.dart';
import 'package:eng/share_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double slideValue = 5;
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKey.counter) ?? 5;
    setState(() {
      slideValue = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: const Text(
          'Your control',
          style: TextStyle(fontSize: 36),
        ),
        leading: InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt(ShareKey.counter, slideValue.toInt());
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: const Text(
                'How much a number word at once?',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Text(
              '${slideValue.toInt()}',
              style: TextStyle(fontSize: 200, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: slideValue,
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  slideValue = value;
                });
              },
              thumbColor: Colors.pink,
              activeColor: Colors.red,
              inactiveColor: Colors.yellow,
              secondaryActiveColor: Colors.green,
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'slide to set',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
