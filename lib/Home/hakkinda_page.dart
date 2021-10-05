import 'package:flutter/material.dart';

class HakkindaPage extends StatelessWidget {
  const HakkindaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 26, top: 25, right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "İngilizce kelimeleri, atasözlerini ve kalıplaşmış bazı cümleleri dinleyerek öğrenebilirsiniz. Kelimelerin telaffuzunu dinlemek için kartlara uzun basabilirsiniz. Türkçe karşılıklarını görmek için ise kartlara bir defa tıklamanız yeterlidir.",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
