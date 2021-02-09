import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

const imageData = [
  "assets/images/wedding_photo/AI4I9251.jpg",
  "assets/images/wedding_photo/AI4I9245.jpg",
  "assets/images/wedding_photo/AI4I9133.jpg",
  "assets/images/wedding_photo/AI4I9278.jpg",
  "assets/images/wedding_photo/AI4I9285.jpg",
  "assets/images/wedding_photo/AI4I9118.jpg",
  "assets/images/wedding_photo/AI4I9327.jpg",
  "assets/images/wedding_photo/AI4I9121.jpg",
  "assets/images/wedding_photo/AI4I9108.jpg",
  "assets/images/wedding_photo/AI4I9268.jpg",
  "assets/images/wedding_photo/AI4I9334.jpg",
  "assets/images/wedding_photo/AI4I9346.jpg",
  "assets/images/wedding_photo/AI4I9187.jpg",
  "assets/images/wedding_photo/AI4I9193.jpg",
  "assets/images/wedding_photo/AI4I9350  30寸满天星框.jpg",
  "assets/images/wedding_photo/AI4I9353.jpg",
  "assets/images/wedding_photo/AI4I9153.jpg",
  "assets/images/wedding_photo/AI4I9283_1.jpg",
  "assets/images/wedding_photo/AI4I9208.jpg",
  "assets/images/wedding_photo/AI4I9156.jpg",
  "assets/images/wedding_photo/AI4I9355.jpg",
  "assets/images/wedding_photo/AI4I9135  80寸海报.jpg",
  "assets/images/wedding_photo/AI4I9342.jpg",
  "assets/images/wedding_photo/AI4I9114  10寸施华洛摆台.jpg",
  "assets/images/wedding_photo/AI4I9189  12寸施华洛摆台.jpg",
  "assets/images/wedding_photo/AI4I9207.jpg",
  "assets/images/wedding_photo/AI4I9159.jpg",
  "assets/images/wedding_photo/AI4I9166.jpg",
  "assets/images/wedding_photo/AI4I9167.jpg",
  "assets/images/wedding_photo/AI4I9239.jpg",
  "assets/images/wedding_photo/AI4I9188.jpg",
  "assets/images/wedding_photo/AI4I9290 8寸拉米娜.jpg",
  "assets/images/wedding_photo/AI4I9174.jpg",
  "assets/images/wedding_photo/AI4I9203.jpg",
  "assets/images/wedding_photo/AI4I9310.jpg",
  "assets/images/wedding_photo/AI4I9271.jpg",
  "assets/images/wedding_photo/AI4I9241封面.jpg",
  "assets/images/wedding_photo/AI4I9356  8寸拉米娜摆台.jpg",
  "assets/images/wedding_photo/AI4I9115.jpg",
  "assets/images/wedding_photo/AI4I9190  36寸满天星框.jpg",
  "assets/images/wedding_photo/AI4I9329.jpg",
  "assets/images/wedding_photo/AI4I9352  钱包卡.jpg",
];
const imageThumbnailData = [
  "assets/images/wedding_photo/compress/thumbnail_AI4I9133.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9251.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9245.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9278.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9285.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9118.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9327.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9121.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9108.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9268.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9334.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9346.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9187.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9193.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9350  30寸满天星框.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9353.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9153.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9283_1.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9208.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9156.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9355.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9135  80寸海报.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9342.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9114  10寸施华洛摆台.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9189  12寸施华洛摆台.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9207.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9159.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9166.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9167.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9239.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9188.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9290 8寸拉米娜.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9174.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9203.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9310.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9271.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9241封面.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9356  8寸拉米娜摆台.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9115.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9190  36寸满天星框.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9329.jpg",
  "assets/images/wedding_photo/compress/thumbnail_AI4I9352  钱包卡.jpg",
];

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: [
              Image.asset(
                imageData[0],
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: 20,
                  width: 300,
                  height: 60,
                  child: Center(
                    child: buildMarquee(),
                  )),
              Positioned(
                  bottom: 20,
                  height: 150,
                  child: Center(
                    child: buildPictureGridView(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMarquee() {
    return Marquee(
      text: "欢迎您～～",
      blankSpace: 20,
      velocity: 50.0,
      style: TextStyle(fontSize: 30, color: Colors.white),
    );
  }

  Widget buildPictureGridView() {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: imageThumbnailData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Image.asset(
            imageThumbnailData[index],
            width: 266,
            height: 150,
            fit: BoxFit.cover,
          );
        });
  }
}
