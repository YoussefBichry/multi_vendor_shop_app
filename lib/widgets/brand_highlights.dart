import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:multi_vendor_shop_app/firebase_service.dart';
import 'package:multi_vendor_shop_app/widgets/banner_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BrandHighlights extends StatefulWidget {
  const BrandHighlights({Key? key}) : super(key: key);

  @override
  State<BrandHighlights> createState() => _BrandHighlightsState();
}

class _BrandHighlightsState extends State<BrandHighlights> {

  double _scrollPosition=0;
  List brandAdsImages = [];
  final FirebaseService _service = FirebaseService();
  @override
  void initState() {
    getBrandAd();
    // TODO: implement initState
    super.initState();
  }

  getBrandAd(){
    return _service.brandAd.get().then((QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
      setState(() {
        brandAdsImages.add(doc);
      });
    }));
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Brand Highlights',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 20

                ),
              ),
            ),
          ),
          Container(
            height: 166,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: PageView.builder(
              itemCount: brandAdsImages.length,
              itemBuilder: (BuildContext context,int index){
                return Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,0,4,8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                height: 100,
                                color: Colors.deepOrange,
                                child: YoutubePlayer(
                                  controller: YoutubePlayerController(
                                    initialVideoId: brandAdsImages[index]['youtube'],
                                    flags: const YoutubePlayerFlags(
                                      autoPlay: false,
                                      mute: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(8,0,4,8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      height: 50,
                                      color: Colors.red,
                                      child:CachedNetworkImage(
                                          imageUrl: brandAdsImages[index]['image1'],
                                          fit:BoxFit.fill,
                                          placeholder: (context, url) => GFShimmer(
                                              child: Container(
                                                height: 50,
                                                color: Colors.grey.shade400,
                                              )
                                          ),
                                        ),

                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(4,0,8,8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      height: 50,
                                      color: Colors.red,
                                      child:CachedNetworkImage(
                                          imageUrl: brandAdsImages[index]['image2'],
                                          fit: BoxFit.fill,
                                        ),

                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8,0,4,8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 160,
                            color: Colors.blue,
                            child:CachedNetworkImage(
                                imageUrl: brandAdsImages[index]['image3'],
                                fit: BoxFit.fill
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              onPageChanged: (val){
                setState(() {
                  _scrollPosition=val.toDouble();
                });
              },
            ),
          ),
          brandAdsImages.isEmpty? Container():
          DotsIndicatorWidget(scrollPosition: _scrollPosition, itemList: brandAdsImages,)
        ],
      ),
    );
  }
}
