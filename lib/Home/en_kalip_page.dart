import 'dart:convert';
import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:game_app_tap/models/sentence.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';

class EnKalipPage extends StatefulWidget {
  const EnKalipPage({Key? key}) : super(key: key);

  @override
  _EnKalipPageState createState() => _EnKalipPageState();
}

class _EnKalipPageState extends State<EnKalipPage> {
  BannerAd? _bannerAd;
  bool _bannerisLoaded = false;

  bool isLoaded = false;

  var myController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  bool yatayEksen = true;
  bool pageSnapping = true;
  bool reverseSira = false;

  List<Sentence>? allSentences;
  late AudioPlayer player;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-2452889629536861/7691870413',
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
    WidgetsFlutterBinding.ensureInitialized();
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
            allSentences = sonuc.data as List<Sentence>?;
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Hero(
                    tag: "${allSentences![index].en}",
                    child: GestureDetector(
                      onLongPress: () async {
                        await player
                            .setAsset(allSentences![index].soundSrc.toString());
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
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              allSentences![index]
                                                  .en!
                                                  .toUpperCase()
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Telafuzu dinlemek için uzun basın.",
                                          style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold),
                                        )
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
                                      allSentences![index]
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
              itemCount: allSentences?.length,
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
        .loadString('assets/data/sentences.json');

    List<Sentence> hayvanListesi = (json.decode(gelenJson) as List)
        .map((mapYapisi) => Sentence.fromJson(mapYapisi))
        .toList();

    return hayvanListesi;
  }
}
