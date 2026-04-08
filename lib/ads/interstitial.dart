import 'package:google_mobile_ads/google_mobile_ads.dart';

InterstitialAd? ad;

void loadAd() {
  InterstitialAd.load(
    adUnitId: InterstitialAd.testAdUnitId,
    request: AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (a) => ad = a,
      onAdFailedToLoad: (e) => ad = null,
    ),
  );
}

void showAd() {
  if (ad != null) {
    ad!.show();
    ad = null;
    loadAd();
  }
}
