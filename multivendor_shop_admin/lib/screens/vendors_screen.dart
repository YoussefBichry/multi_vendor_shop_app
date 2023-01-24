import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/vendor_list.dart';




class VendorScreen extends StatefulWidget {
  static const String id ='vendors-screen';
  const VendorScreen({Key? key}) : super(key: key);

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  Widget _rowHeader({int? flex, String? text}){
    return Expanded(
        flex: flex!,
        child: Container(

          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey.shade500
            ),
            color: Colors.grey.shade400,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text!,style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
          ),
        ));
  }
  bool? _selectedButton;

  @override
  Widget build(BuildContext context) {


    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                  'Registred Vendors',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22
              ),),
              SizedBox(height:10),
              Container(
                child: Row(
                  children: [
                    ElevatedButton(
                        style:ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(_selectedButton == true ? Theme.of(context).primaryColor: Colors.grey.shade500)
                ),
                        onPressed: (){
                          setState(() {
                            _selectedButton=true;
                          });
                        },
                        child: Text("Approved")
                    ),
                    SizedBox(width:10),
                    ElevatedButton(
                        style:ButtonStyle(
    backgroundColor: MaterialStateProperty.all(_selectedButton == false ? Theme.of(context).primaryColor:Colors.grey.shade500)
    ),
                        onPressed: (){
                          setState(() {
                            _selectedButton = false;
                          });

                    }, child: Text("Not approved")),
                    SizedBox(width:10),
                    ElevatedButton(
                        style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(_selectedButton == null ? Theme.of(context).primaryColor:Colors.grey.shade500)
                        ),
                        onPressed: (){
                          setState(() {
                            _selectedButton=null;
                          });
                    }, child: Text("All"))
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
             _rowHeader(flex: 1, text: 'Logo'),
             _rowHeader(flex: 2, text: 'Business Name'),
             _rowHeader(flex: 2, text: 'City'),
             _rowHeader(flex: 2, text: 'STATE'),
             _rowHeader(flex: 1, text: 'ACTION'),
             _rowHeader(flex: 1, text: 'VIEW MORE'),
            ],
          ),
          VendorList(
            approveStatus: _selectedButton
          ),
        ],
      ),
    );
  }
}
