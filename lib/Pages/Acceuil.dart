import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:http/http.dart' as http;

class AcceuilPage extends StatefulWidget {
  const AcceuilPage({super.key});


  @override
  State<AcceuilPage> createState() => _AcceuilPageState();
}

class _AcceuilPageState extends State<AcceuilPage> {

  Future <void> nomville(double latitude,double longitude) async {
    final url=Uri.parse("https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=json");
    final reponse=await http.get(url,headers: {
      'User-Agent': 'MonAppFlutter/1.0 (votre@email.com)' // obligatoire pour Nominatim
    },);
    var message=jsonDecode(reponse.body);
    setState(() {
      nom_de_la_ville=message["address"]["city"];
    });
    print(message["address"]["city"]);
  }
  final MapController _mapController = MapController();
  StreamSubscription<Position>? _positionStreamSubscription;
  double longitude = 0;
  double latitude = 0;
  var nom_de_la_ville;
  void localisation() async {
    // Check and request permission
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }


    try {
      Position initialPosition = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() {
          latitude = initialPosition.latitude;
          longitude = initialPosition.longitude;
        });
      }
    } catch (e) {
      print("Erreur pour obtenir la position initiale: $e");
    }



    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
          if (mounted) {
            setState(() {
              latitude = position.latitude;
              longitude = position.longitude;
              _mapController.move(LatLng(latitude, longitude), _mapController.zoom);
            });
            nomville(latitude, longitude);
          }
        });
  }

  @override
  void initState() {
    super.initState();
    localisation();

  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    // Show a loading indicator until the first location is available
    if (latitude == 0 && longitude == 0) {
      return  Scaffold(
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height *0.2,),
            Container(width: MediaQuery.of(context).size.width *1,),
            Container(child: Lottie.asset("assets/animations/chargement.json"),),
            Container(child: Text("CHARGEMENT...."),)
        ],))
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(latitude, longitude),
              initialZoom: 16,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.hackaton',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(latitude, longitude),
                    width: 80,
                    height: 80,
                    child: Icon(Icons.location_on,
                        color: Colors.red, size: 40),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.07),decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1))),child: CircleAvatar(backgroundColor: Colors.white,radius:MediaQuery.of(context).size.width *0.05,child: IconButton(onPressed: (){}, icon: Icon(Icons.menu,size: MediaQuery.of(context).size.width *0.05,color: Colors.green),),)
            ),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.07),height: MediaQuery.of(context).size.height *0.065,width: MediaQuery.of(context).size.width *0.6,decoration:BoxDecoration(border: Border.all(color: Colors.black),color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1),),),child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.location_on,size: MediaQuery.of(context).size.width *0.05,),
              SizedBox(width: MediaQuery.of(context).size.width *0.03,),
              Text(nom_de_la_ville!=null?nom_de_la_ville:"Chargement",textAlign: TextAlign.center,style: TextStyle(fontSize: MediaQuery.of(context).size.width *0.04),)
            ],),),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.07),decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1))),child: CircleAvatar(backgroundColor: Colors.white,radius:MediaQuery.of(context).size.width *0.05,child: IconButton(onPressed: (){}, icon: Icon(Icons.manage_accounts_sharp,size: MediaQuery.of(context).size.width *0.05,color: Colors.green),),)
            ),
          ],),
        Container(
            child: ListView.builder(itemCount: 2,itemBuilder: (context, index) {
              return Stack(
                 alignment: AlignmentGeometry.center,
                children: [
                Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height *0.025),child: ListTile(title: Text("service",style: TextStyle(overflow: TextOverflow.ellipsis,color: Colors.white)),subtitle: Text("service en cours",style: TextStyle(overflow: TextOverflow.ellipsis),),leading: CircleAvatar(radius: MediaQuery.of(context).size.width *0.075,),),height: 80,width: 250,decoration: BoxDecoration(color: Colors.lightGreen,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.15))),)
                  ,Container(margin:EdgeInsets.only(left: MediaQuery.of(context).size.width *0.68),child: CircleAvatar(radius:MediaQuery.of(context).size.width *0.07 ,child: Icon(Icons.arrow_forward),),)
                ],
              );
            },),decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width *0.15),topRight: Radius.circular(MediaQuery.of(context).size.width *0.15))),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.7,),height: MediaQuery.of(context).size.height *0.3,width: MediaQuery.of(context).size.width *1)
        ],
      ),
    );
  }
}