import 'package:daily_exercise/DAY/challengday.dart';
import 'package:daily_exercise/allexecise/exercise.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Day extends StatefulWidget {
  const Day({super.key});

  @override
  _Day30State createState() => _Day30State();
}

class _Day30State extends State<Day> {
  Set<int> completedDays = Set();

  @override
  void initState() {
    super.initState();
    _loadCompletedDays();
  }

  _loadCompletedDays() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> completedDaysList = prefs.getStringList('completedDays') ?? [];
    setState(() {
      completedDays = completedDaysList.map((day) => int.parse(day)).toSet();
    });
  }

  _markDayAsCompleted(int day) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      completedDays.add(day);
    });
    prefs.setStringList('completedDays', completedDays.map((day) => day.toString()).toList());
    if (completedDays.length == 30) {
      _showCongratulatoryPopup();
    }
  }

  _showCongratulatoryPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have completed the 30-day challenge!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (Contex) => ChallengeSelectionPage()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DAY"),
        backgroundColor: Color(0xffb135D66),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/image/back.jpg',
            fit: BoxFit.cover,
          ),
          ListView.builder(
            itemCount: 30,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              bool isCompleted = completedDays.contains(index + 1);
              return Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => exercise(
                          onExerciseComplete: () {
                            _markDayAsCompleted(index + 1);
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color(0xffb83B4FF), // border color
                        width: 4, // border width
                      ),
                      color: isCompleted ? Color(0xff219C90) : Colors.transparent,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Day - ${index + 1}',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xffbFDFF2),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Exercises',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xffbFDFF2),
                              ),
                            ),
                            SizedBox(width: 65,),
                            if (isCompleted)
                              Text(
                                '✓Completed',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xffbFDFF2),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xffbFDFF2
                        ),
                    ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
