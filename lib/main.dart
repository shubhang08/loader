import 'package:flutter/material.dart';
import './Loader.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:MyDetail() ,
  ) );

}
class MyDetail extends StatefulWidget {
  const MyDetail({Key? key}) : super(key: key);

  @override
  State<MyDetail> createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Center(child: Loader()),

      ),
    );
  }
}
