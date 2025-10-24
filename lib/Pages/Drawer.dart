import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hackaton/Pages/Acceuil.dart';
import 'package:hackaton/Pages/Menu.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}
final ZoomDrawerController _controller = ZoomDrawerController();

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuBackgroundColor: Colors.lightGreen,
        controller: _controller,
        mainScreenTapClose: true,
        angle: 0,
        slideWidth: MediaQuery.of(context).size.width *0.7,
        showShadow: true,
        shadowLayer1Color: Colors.lightGreen[200],
        shadowLayer2Color: Colors.green[100],
        menuScreen: MenuPage(controller: _controller), mainScreen: AcceuilPage(controller: _controller));
  }
}
