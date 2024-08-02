import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BMI.dart';
import 'DAY/challengday.dart';
import 'DAY/Day.dart';
import 'DAY/Day60.dart';
import 'DAY/Day90.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> navigateToChallengePage(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedChallenge = prefs.getString('selectedChallenge');

    if (selectedChallenge != null) {
      switch (selectedChallenge) {
        case '30day':
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Day()));
          break;
        case '60day':
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Day60()));
          break;
        case '90day':
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Day90()));
          break;
        default:
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChallengeSelectionPage()));
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChallengeSelectionPage()));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Start Exercise',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/image/back1.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChallengeSelectionPage()),
                    );
                  },
                  child: Text('Start exercise'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xffbFDFF2),
                    backgroundColor: Colors.teal, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), // Padding
                  ),
                ),
              ),

            ],
          ),
        ],
      ),

    );

  }
}