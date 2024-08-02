import 'package:daily_exercise/allexecise/exercise.dart';
import 'package:daily_exercise/allexecise/exercise1.dart';
import 'package:daily_exercise/allexecise/exercise2.dart';
import 'package:daily_exercise/allexecise/exercise3.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class exercise2 extends StatefulWidget {
  final Function onExerciseComplete;

  const exercise2({Key? key, required this.onExerciseComplete}) : super(key: key);

  @override
  _exercise1State createState() => _exercise1State();
}

class _exercise1State extends State<exercise2> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3360248233029568/6785841834', // Replace with your ad unit ID
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Banner ad loaded.');
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Banner ad failed to load: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RUN'),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 400,
                      margin: EdgeInsets.all(20),
                      color: Colors.white10,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset('assets/image/exercise2.gif'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.navigate_before),
                          tooltip: 'Preview',
                          iconSize: 35,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => exercise1(
                                  onExerciseComplete: () {
                                    Navigator.pop(context);
                                    widget.onExerciseComplete();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        Text(
                          '15 min',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 35,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next_outlined),
                          tooltip: 'Next',
                          iconSize: 35,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => exercise3(
                                  onExerciseComplete: () {
                                    Navigator.pop(context);
                                    widget.onExerciseComplete();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isAdLoaded)
            Container(
              alignment: Alignment.bottomCenter,
              child: AdWidget(ad: _bannerAd!),
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
            ),
        ],
      ),
    );
  }
}
