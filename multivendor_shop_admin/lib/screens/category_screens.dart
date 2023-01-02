import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = 'category';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Categories',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 26,
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
        Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey.shade800)
                    ),
                    child: Center(child: Text('Category Image')),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){}, child: Text("Upload Image"))
                ],
              ),
              const SizedBox(width: 20,),
              Container(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    label: Text("Enter Category Name"),
                    contentPadding: EdgeInsets.zero
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              TextButton(
                onPressed: (){},
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                side: MaterialStateProperty.all(BorderSide(
                  color:Theme.of(context).primaryColor
                ))
              ) ,
                child: Text('Cancel',
                  style: TextStyle(color: Theme.of(context).primaryColor),),
              ),
              const SizedBox(width: 10,),
              ElevatedButton(
                onPressed: (){},
                child: Text('Save',
                  style: TextStyle(color: Theme.of(context).primaryColor),),
              ),
            ],
        ),
        const Divider(
          color: Colors.grey,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Category List',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
