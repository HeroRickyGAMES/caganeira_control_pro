import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

//Programado por HeroRickyGames

class mobileAds extends StatefulWidget {
  const mobileAds({Key? key}) : super(key: key);

  @override
  State<mobileAds> createState() => _mobileAdsState();
}
bool isInDebug = false;
bool falhouAoCarregar = false;
class _mobileAdsState extends State<mobileAds> {
  final adUnitId = 'ca-app-pub-1895475762491539/8782552150';
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  Future<void> loadAd() async {

    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if(isInDebug){
            debugPrint('${ad.responseInfo} loaded.');
          }
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          if(isInDebug){
            debugPrint('BannerAd failed to load: $error');
          }
          setState(() {
            falhouAoCarregar = true;
          });
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }
  @override
  void dispose() {

    _bannerAd?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _bannerAd != null ? Align(
      alignment: Alignment.bottomCenter,
      child: falhouAoCarregar == false ? SafeArea(
        child: SizedBox(
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        ),
      ):Center(
        child: Text(
          'Anuncio não carregado!\nIsso se dá se caso estiver usando um ADBlocker, por favor evite usar AdBlocker enquanto usa o app! Caso não esteja usando ignore essa mensagem!',
          style: TextStyle(
              color: Colors.red[800]
          ),
        ),
      ),
    ):
    const Center(
      child: Text(
        'Carregando anuncio...',
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }
}

int maxFailedLoadAttempts = 3;

void interAdReward(bool isPremium) async {
  if(isPremium == false){
    MobileAds.instance.initialize();
    InterstitialAd? interstitialAd;
    int numInterstitialLoadAttempts = 0;
    const AdRequest request = AdRequest(
      keywords: <String>['foo', 'bar'],
      contentUrl: 'http://foo.com/bar.html',
      nonPersonalizedAds: true,
    );

    void _createInterstitialAd() {
      InterstitialAd.load(
          adUnitId: "ca-app-pub-1895475762491539/8553612556",
          request: request,
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              if (kDebugMode) {
                print('$ad loaded');
              }
              interstitialAd = ad;
              numInterstitialLoadAttempts = 0;
              interstitialAd!.setImmersiveMode(true);
            },
            onAdFailedToLoad: (LoadAdError error) {
              if (kDebugMode) {
                print('InterstitialAd failed to load: $error.');
              }
              numInterstitialLoadAttempts += 1;
              interstitialAd = null;
              if (numInterstitialLoadAttempts < maxFailedLoadAttempts) {
                _createInterstitialAd();
              }
            },
          ));
    }

    void _showInterstitialAd() {
      if (interstitialAd == null) {
        print('Warning: attempt to show interstitial before loaded.');
        return;
      }
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
          if (kDebugMode) {
            print('ad onAdShowedFullScreenContent.');
          }},
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          if (kDebugMode) {
            print('$ad onAdDismissedFullScreenContent.');
          }
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          if (kDebugMode) {
            print('$ad onAdFailedToShowFullScreenContent: $error');
          }
          ad.dispose();
          _createInterstitialAd();
        },
      );
      interstitialAd!.show();
      interstitialAd = null;
    }
    _createInterstitialAd();
    showinterad() async {
      await Future.delayed(const Duration(seconds: 5));
      _showInterstitialAd();
    }
    showinterad();
  }else{

  }
}
