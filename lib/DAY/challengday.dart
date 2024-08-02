import 'package:daily_exercise/BMI.dart';
import 'package:daily_exercise/DAY/Day.dart';
import 'package:daily_exercise/DAY/Day60.dart';
import 'package:daily_exercise/DAY/Day90.dart';
import 'package:daily_exercise/bottom_navigation/basicinfo.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ChallengeSelectionPage extends StatefulWidget {
  @override
  _ChallengeSelectionPageState createState() => _ChallengeSelectionPageState();
}

class _ChallengeSelectionPageState extends State<ChallengeSelectionPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    Bmi(),
    BasicinfoScreen(),
  ];

  final List<Color> _navBarColors = [
    Colors.blue,
    Color(0xffb50B498),
    Colors.blue,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: _navBarColors[_currentIndex],
        color: _navBarColors[_currentIndex],
        buttonBackgroundColor: Color(0xffb405D72),
        height: 60,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.health_and_safety_outlined, size: 30, color: Colors.white),
          Icon(Icons.info, size: 30, color: Colors.white),
        ],
        animationDuration: Duration(milliseconds: 200),
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHALLENGE'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Center(
          child: Column(
            children: [
              Container(
               alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 25),
                  child: Text('Basic',style: TextStyle(fontSize: 25),)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Day()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 10),
                        height: 290,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white, // border color
                            width: 4, // border width
                          ),
                          image: DecorationImage(
                            image: AssetImage('assets/image/30b.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Day60()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 20,right: 20),
                        height: 300,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white, // border color
                            width: 4, // border width
                          ),
                          image: DecorationImage(
                            image: AssetImage('assets/image/60b.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ),
              SizedBox(height: 50,),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 25),
                  child: Text('Advance',style: TextStyle(fontSize: 25),)),

              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Day90()));
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.only(top: 5, left: 10,),
                    height: 280,
                    width: 430,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white, // border color
                        width: 4, // border width
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/image/90b.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

