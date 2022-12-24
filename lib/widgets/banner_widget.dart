import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';


class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  double scrollPosition=0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8,0,8,8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: PageView(
                onPageChanged: (val){
                  setState(() {
                    scrollPosition=val.toDouble();
                  });
                },
                children: const [
                  Center(
                    child: Text(
                      'Banner 1',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Banner 2',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Banner 3',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

            ),
          ),

        ),
        Positioned(
          bottom: 10.0,
          child: DotsIndicatorWidget(scrollPosition: scrollPosition),
        )
      ],

    );
  }
}

class DotsIndicatorWidget extends StatelessWidget {
  const DotsIndicatorWidget({
    Key? key,
    required this.scrollPosition,
  }) : super(key: key);

  final double scrollPosition;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DotsIndicator(
            position: scrollPosition,
            dotsCount: 3,
            decorator: DotsDecorator(
                activeColor: Colors.blue.shade900,
                spacing: const EdgeInsets.all(2),
                size: const Size.square(6),
                activeSize: Size(12,6),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)
                )

            ),

          ),
        )
      ],


    );
  }
}

