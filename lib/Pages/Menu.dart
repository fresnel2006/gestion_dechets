import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/src/drawer_controller.dart';
import 'package:lottie/lottie.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required ZoomDrawerController controller});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        CircleAvatar(backgroundColor: Colors.white ,radius: 45,child: Lottie.asset("assets/animations/deploiement.json"),),
          SizedBox(height: 20,),
          Container(height: 40,
            width: 150,color: Colors.white,),
          SizedBox(height: 20,),
          Container(height: 40,
            width: 150,color: Colors.white,),
          SizedBox(height: 20,),
          Container(height: 40,
            width: 150,color: Colors.white,)
      ],),
    );
  }
}
