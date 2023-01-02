import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_shop_app/firebase_service.dart';
import 'package:getwidget/getwidget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  FirebaseService service = FirebaseService();
  double scrollPosition=0;
  List images_banner = [];
  @override
  void initState() {
    getBanners();
    // TODO: implement initState
    super.initState();
  }

  getBanners(){
    return service.homebanner.get().then((QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
      setState(() {
        images_banner.add(doc['image']);
      });
    }));
  }

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
              child: PageView.builder(
                itemCount: images_banner.length,
                itemBuilder: (BuildContext context,int index){
                  return CachedNetworkImage(
                    imageUrl: images_banner[index],
                    placeholder: (context, url) =>GFShimmer(
                      child: Container(
                        color: Colors.grey.shade300,
                      ),
                      mainColor: Colors.grey.shade500,
                      secondaryColor: Colors.grey.shade500,
                      showShimmerEffect: true,
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  );
                },
                onPageChanged: (val){
                  setState(() {
                    scrollPosition=val.toDouble();
                  });
                },

              ),
            ),
          ),
        ),
        images_banner.isEmpty? Container():
        Positioned(
          bottom: 10.0,
          child: DotsIndicatorWidget(scrollPosition: scrollPosition, itemList:images_banner),
        )
      ],

    );
  }
}

class DotsIndicatorWidget extends StatelessWidget {
  const DotsIndicatorWidget({
    Key? key,
    required this.scrollPosition,
    required this.itemList
  }) : super(key: key);

  final double scrollPosition;
  final List itemList;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DotsIndicator(
            position: scrollPosition,
            dotsCount: itemList.length,
            decorator: DotsDecorator(
                activeColor: Colors.blue.shade900,
                spacing: const EdgeInsets.all(2),
                size: const Size.square(6),
                activeSize: const Size(12,6),
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

