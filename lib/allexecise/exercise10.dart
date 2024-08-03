import 'package:daily_exercise/DAY/challengday.dart';
import 'package:daily_exercise/allexecise/exercise.dart';
import 'package:daily_exercise/allexecise/exercise9.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class exercise10 extends StatefulWidget {
  final Function onExerciseComplete;

  const exercise10({Key? key, required this.onExerciseComplete}) : super(key: key);

  @override
  _exercise10State createState() => _exercise10State();
}

class _exercise10State extends State<exercise10> {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  bool _isBannerAdLoaded = false;
  bool _isInterstitialAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _loadInterstitialAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3360248233029568/6785841834',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Banner ad loaded.');
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Banner ad failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3360248233029568/5662162547',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('Interstitial ad loaded.');
          _interstitialAd = ad;
          _isInterstitialAdLoaded = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isInterstitialAdLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      _isInterstitialAdLoaded = false;
      _loadInterstitialAd();
    } else {
      print('Interstitial ad is not ready yet.');
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
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
                          Image.asset('assets/image/exercise10.gif'),
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
                                builder: (context) => exercise9(
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
                          'X 15',
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
                            widget.onExerciseComplete();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChallengeSelectionPage(),
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
          if (_isBannerAdLoaded)
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
