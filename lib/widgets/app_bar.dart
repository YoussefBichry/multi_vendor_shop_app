import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';


  PreferredSizeWidget? appBarWidget(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        centerTitle: true,
        title: const Text('Smile Shop',style: TextStyle(letterSpacing: 2),),
        actions: [
          IconButton(
            icon: const Icon(IconlyLight.buy), onPressed: () {  },
          )
        ],
      ),
    );
  }
