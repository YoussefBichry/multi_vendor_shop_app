import 'package:flutter/material.dart';
import 'package:multi_vendor_shop_app/core/constants.dart';
import 'package:multi_vendor_shop_app/widgets/app_bar.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: Stack(
        children: [
          Image.asset('assets/images/welcome_picture.jpg',height: Constants.getSizeHeight(context),fit: BoxFit.fill,scale: 2,),
          ButtonSignUp(context),
          Positioned(
            bottom: Constants.getSizeHeight(context)/15,
            left: 40,
            child: Row(
              children: [
                Text("Already have an account?",style: TextStyle(fontSize: 16),),
                GestureDetector(
                  onTap: (){},
                  child: Text("Login",style: TextStyle(color: Colors.blueGrey,fontSize: 16),),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

Widget ButtonSignUp(BuildContext context)
{
  return Positioned(
      left: Constants.getSizeWidth(context)/4,
      bottom: Constants.getSizeHeight(context)/9,
      child: Container(
          width: 200,
          child:ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
            onPressed: () {}, child: Text("Signup",style: TextStyle(fontSize: 15),),

          )
      )

  );
  
}