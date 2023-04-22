import 'dart:math';
import 'package:eng/control_page.dart';
import 'package:eng/share_key.dart';
import 'package:eng/widgets/appButton.dart';
import 'package:english_words/english_words.dart';
import 'package:eng/models/english_today.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currIndex = 0;
  final PageController _pageController = PageController();

  List<EnglishToday> words = [];
  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max && len < min) {
      return [];
    }
    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async {
    List<String> newList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKey.counter) ?? 5;
    List<int> rans = fixedListRandom(len: len, max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });
    setState(() {
      words = newList
          .map((e) => EnglishToday(
                noun: e,
              ))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEnglishToday();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  Color colorBt = Colors.white;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _key,
        backgroundColor: Colors.cyan,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0,
          title: const Text(
            'English today',
            style: TextStyle(fontSize: 36),
          ),
          leading: InkWell(
            child: const Icon(Icons.menu),
            onTap: () {
              _key.currentState?.openDrawer();
            },
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16),
                  child: Text(
                    'Your mind',
                    style: TextStyle(fontSize: 46, color: Colors.white),
                  ),
                ),
                AppButton(
                    label: 'Favorite',
                    onTap: () {
                      print('favorite');
                    }),
                AppButton(
                    label: 'Your control',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ControlPage()));
                    })
              ],
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: size.height * 1 / 10,
                //padding: const EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                child: const Text(
                  '"It is amazing how complete is the delusion that beauty is goodness"',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(3, 6),
                      blurRadius: 20)
                ]),
                height: size.height * 2 / 3,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currIndex = index;
                      });
                    },
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      String firstLetter =
                          words[index].noun != null ? words[index].noun! : '';
                      firstLetter = firstLetter.substring(0, 1);

                      String leftLetter =
                          words[index].noun != null ? words[index].noun! : '';
                      leftLetter = leftLetter.substring(1, leftLetter.length);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue[200],
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (colorBt != Colors.red) {
                                          colorBt = Colors.red;
                                        } else {
                                          colorBt = Colors.white;
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.heart_broken,
                                      color: colorBt,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              ),
                              RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                      text: firstLetter,
                                      style: const TextStyle(
                                          fontSize: 100,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(2, 6),
                                              blurRadius: 5,
                                            )
                                          ]),
                                      children: [
                                        TextSpan(
                                            text: leftLetter,
                                            style: const TextStyle(
                                                fontSize: 70,
                                                shadows: [
                                                  BoxShadow(
                                                    offset: Offset.zero,
                                                  )
                                                ]))
                                      ])),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 24.0, left: 10, right: 40),
                                child: Text(
                                  '"Think of all the beauty still left around you and be happy."',
                                  style: TextStyle(
                                    fontSize: 28,
                                    letterSpacing: 1,
                                    height: 1.4,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              _currIndex >= 5
                  ? buildShowMore()
                  : Container(
                      height: size.height * 1 / 11,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return buildIndicator(index == _currIndex, size);
                          }),
                    )
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: 80,
          width: 80,
          child: FloatingActionButton(
            onPressed: () {
              getEnglishToday();
            },
            backgroundColor: Colors.blue[900],
            child: const Icon(
              Icons.refresh,
              size: 40,
            ),
          ),
        ));
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 12),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? Colors.lightBlue : Colors.blueGrey,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(2, 3),
              blurRadius: 2,
            )
          ]),
    );
  }

  Widget buildShowMore() {
    return Container(
      color: Colors.red,
    );
  }
}
