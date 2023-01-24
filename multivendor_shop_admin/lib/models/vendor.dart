import 'package:cloud_firestore/cloud_firestore.dart';

class Vendor {

  Vendor(
      {this.approved,
        this.businessName,
        this.city,
        this.country,
        this.email,
        this.landmark,
        this.logo,
        this.shopImage,
        this.mobile,
        this.pincode,
        this.taxRegistred,
        this.time,
        this.tinNumber,
        this.state,
        this.uid});


  Vendor.fromJson(Map<String, Object?> json)
      : this(
    approved: json['approved'] as bool,
    businessName: json['businessName'] as String?,
    city: json['city'] as String?,
    state: json['state'] as String?,
    country: json['country'] as String?,
    email: json['email'] as String?,
    landmark: json['landmark'] as String?,
    logo: json['logo'] as String?,
    shopImage: json['shopImage'] as String?,
    mobile: json['mobile'] as String?,
    pincode: json['pincode'] as String?,
    taxRegistred: json['taxRegistred'] as String?,
    tinNumber: json['tinNumber'] as String?,
    time: json['time'] as Timestamp,
    uid: json['uid'] as String?,
  );

  final bool? approved;
  final String? businessName;
  final String? city;
  final String? state;
  final String? country;
  final String? email;
  final String? landmark;
  final String? logo;
  final String? shopImage;
  final String? mobile;
  final String? pincode;
  final String? taxRegistred;
  final Timestamp? time;
  final String? tinNumber;
  final String? uid;

  Map<String, Object?> toJson() {
    return {
      'approved':approved,
      'businessName':businessName,
      'city':city,
      'state':state,
      'country':country,
      'email':email,
      'landmark':landmark,
      'logo':logo,
      'shopImage':shopImage,
      'mobile':mobile,
      'pincode':pincode,
      'taxRegistred':taxRegistred,
      'tinNumber':tinNumber,
      'time':time,
      'uid':uid
    };
  }


}