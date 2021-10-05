import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_app_tap/Home/en_kalip_page.dart';
import 'package:game_app_tap/Home/en_page.dart';
import 'package:game_app_tap/Home/hakkinda_page.dart';
import 'package:game_app_tap/Home/tr_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int secilenMenuItem = 0;
  late List<Widget> tumSayfalar;
  Widget _trPage = TurkcePage();
  Widget _enPage = EnglishPage();
  Widget _enKalipPage = EnKalipPage();
  Widget _hakkindaPage = HakkindaPage();

  InterstitialAd? _interstitialAd;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-2452889629536861/7397546316',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(
            () {
              isLoaded = true;
              this._interstitialAd = ad;
              print("Ad loaded");
            },
          );
        },
        onAdFailedToLoad: (error) {
          print("Interstitial Failed to Load");
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tumSayfalar = [_trPage, _enPage, _enKalipPage, _hakkindaPage];

    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text("Learn to English")),
          backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.amber),
                accountName: Text("Muhammed"),
                accountEmail: Text("Duruş"),
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: AssetImage("assets/images/profile.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                child: Text("asasasasasa"),
              )
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationBar(context),
        backgroundColor: Colors.black,
        body: tumSayfalar[secilenMenuItem],
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: "EN/TR",
            backgroundColor: Color(0xff392860)),
        BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            label: "Atasözleri",
            backgroundColor: Colors.blue),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: "Kalıp Cümleler",
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: "Uygulama Hakkında",
            backgroundColor: Colors.amber),
      ],
      type: BottomNavigationBarType.shifting,
      currentIndex: secilenMenuItem,
      onTap: (index) {
        setState(() {
          secilenMenuItem = index;
          if (secilenMenuItem == 2) {
            if (isLoaded) {
              _interstitialAd!.show();
            }
          }
        });
      },
    );
  }
}
