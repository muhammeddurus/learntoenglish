import 'dart:convert';
import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:game_app_tap/models/word.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';

class TurkcePage extends StatefulWidget {
  const TurkcePage({Key? key}) : super(key: key);

  @override
  _TurkcePageState createState() => _TurkcePageState();
}

class _TurkcePageState extends State<TurkcePage> {
  BannerAd? _bannerAd;
  bool _bannerisLoaded = false;

  bool isLoaded = false;

  late AudioPlayer player;
  List<Word>? allWord;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-2452889629536861/1509605440',
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          _bannerisLoaded = true;
        });
        print("Banner Loaded.");
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
      }),
      request: AdRequest(),
    );
    _bannerAd!.load();
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: buildFutureBuilder(),
          ),
        ),
        _bannerisLoaded
            ? Container(
                color: Colors.black,
                height: 50,
                child: AdWidget(
                  ad: _bannerAd!,
                ),
              )
            : SizedBox(),
      ],
    );
  }

  FutureBuilder<List<dynamic>> buildFutureBuilder() {
    return FutureBuilder(
        future: veriKaynaginiOku(),
        builder: (context, sonuc) {
          //future un döndürdüğü SONUÇ u sonuca atıyoruz.
          if (sonuc.hasData) {
            allWord = sonuc.data as List<Word>?;
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Hero(
                    tag: "${allWord![index].en}",
                    child: GestureDetector(
                      onLongPress: () async {
                        await player
                            .setAsset(allWord![index].soundSrc.toString());
                        player.play();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              width: 350,
                              height: 350,
                              margin: EdgeInsets.all(10),
                              child: FlipCard(
                                direction: FlipDirection.HORIZONTAL,
                                front: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          allWord![index]
                                              .en!
                                              .toUpperCase()
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Telafuzu dinlemek için uzun basın.",
                                          style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(Icons.volume_up),
                                      ],
                                    ),
                                  ],
                                ),
                                back: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      allWord![index]
                                          .tr!
                                          .toUpperCase()
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: allWord?.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<List> veriKaynaginiOku() async {
    var gelenJson = await DefaultAssetBundle.of(context)
        .loadString('assets/data/dictionary.json');

    List<Word> hayvanListesi = (json.decode(gelenJson) as List)
        .map((mapYapisi) => Word.fromJson(mapYapisi))
        .toList();

    return hayvanListesi;
  }
}
/*
 Column(
      children: [
        Expanded(
          child: Container(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {},
                  child: GestureDetector(
                    child: Container(
                      child: Center(
                          child: Text(
                        "Muhammed",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(20),
                        shape: BoxShape.rectangle,
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                    onTap: () =>
                        debugPrint('Merhaba Flutter $index tıklanıldı'),
                    onDoubleTap: () =>
                        debugPrint('Merhaba Flutter $index çift tıklanıldı'),
                    onLongPress: () =>
                        debugPrint('Merhaba Flutter $index uzun basıldı'),
                    onHorizontalDragStart: (e) =>
                        debugPrint('Merhaba Flutter $index tıklanıldı $e'),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ); 
*/
/*
decoration: BoxDecoration(
                              color: Colors.pink[100 * ((index + 1) % 8)],
                              gradient: LinearGradient(
                                  colors: [Colors.yellow, Colors.transparent],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),

                              border: Border.all(
                                  color: Colors.transparent,
                                  width: 5,
                                  style: BorderStyle.solid),
                              // borderRadius: new BorderRadius.all(new Radius.circular(5)),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.yellow,
                                  offset: new Offset(10.0, 5.0),
                                  blurRadius: 20.0,
                                )
                              ],
                              shape: BoxShape.rectangle,
                            ),
 */
