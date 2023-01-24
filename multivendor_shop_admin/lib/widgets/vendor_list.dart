import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multivendor_shop_admin/firebaseServices.dart';

import '../models/vendor.dart';


class VendorList extends StatelessWidget {
  final bool? approveStatus;
  const VendorList({Key? key,this.approveStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    Widget _vendorData({String? text, int? flex, Widget? widget}){
      return Expanded(
        flex: flex!,
        child: Container(
          height: 66,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.shade400
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget ?? Text(text!),
          ),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _service.vendors.where('approved', isEqualTo:approveStatus).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }
        
        if(snapshot.data!.size == 0){
          return Center(
            child: Text("No vendors to show",
            style: TextStyle(
              fontSize: 22
            ),),
          );
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index){
              Vendor data = Vendor.fromJson(snapshot.data?.docs[index].data() as Map<String, dynamic>);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _vendorData(flex: 1,widget: Container(
                      height: 50,
                      width: 50,
                      child: Image.network(data.logo!,fit: BoxFit.cover,))),
                  _vendorData(flex: 2, text: data.businessName),
                  _vendorData(flex: 2, text: data.city),
                  _vendorData(flex: 2, text: data.state),
                  _vendorData(flex: 1, widget: data.approved ==true? FittedBox(
                    child: FittedBox(
                      child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                          onPressed: (){
                            EasyLoading.show();
                            _service.updateData(
                                data: {
                                  'approved':false
                                },
                                docName: data.uid,
                                reference: _service.vendors
                            ).then((value){
                              EasyLoading.dismiss();
                            });

                      }, child: Text("Reject")
                      ),
                    ),
                  ): ElevatedButton(
                      onPressed: (){
                        EasyLoading.show();
                        _service.updateData(
                          data: {
                            'approved':true
                          },
                          docName: data.uid,
                          reference: _service.vendors
                        ).then((value){
                          EasyLoading.dismiss();
                        });
                      },
                      child: Text("Approve"),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                  ),),
                  _vendorData(flex: 1, widget: ElevatedButton(onPressed: (){}, child: Text("View More"),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                      )
                  ),
                ],
              );
            }
        );
      },
    );
  }
}
