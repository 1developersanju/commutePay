// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math' as math show pi;

import 'package:bus_proj/History/history.dart';
import 'package:bus_proj/Wallet/wallet.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Notification/Notif_page.dart';

class SidebarPage extends StatefulWidget {
  String name;
  SidebarPage({required this.name});
  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  late List<CollapsibleItem> _items;
  Widget _headline = WalletView();
  //  GoogleMap(
  //     initialCameraPosition: CameraPosition(target: LatLng(20.5937, 78.9629)));
  AssetImage _avatarImg = AssetImage('assets/man.png');
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    // _headline = _items.firstWhere((item) => item.isSelected).text;
    getCurrentLocation();
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Track',
        icon: Icons.map,
        onPressed: () => setState(() => _headline = GoogleMap(
              // markers: Marker(markerId: markerId),
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      _currentPosition?.latitude ?? 11.10301344952768,
                      _currentPosition?.longitude ?? 76.96438295281736),
                  zoom: 13),
            )),
      ),
      CollapsibleItem(
          text: 'Wallet',
          icon: Icons.wallet,
          onPressed: () => setState(
                () => _headline = WalletView(),
              ),
          isSelected: true),
      CollapsibleItem(
        text: 'History',
        icon: Icons.history,
        onPressed: () => setState(() => _headline = HistoryView()),
      ),
      CollapsibleItem(
        text: 'Notifications',
        icon: Icons.notifications,
        onPressed: () => setState(() => _headline = NotificationPage()),
      ),
    ];
  }

  void getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print("errrror:$e");
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        isCollapsed: MediaQuery.of(context).size.width <= 800,
        items: _items,
        avatarImg: const NetworkImage(
            "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHBlb3BsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
        title: '${widget.name}',
        onTitleTap: () {},
        body: _headline,
        backgroundColor: Colors.black,
        selectedTextColor: Colors.limeAccent,
        textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        sidebarBoxShadow: [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 20,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
          // BoxShadow(
          //   color: Colors.green,
          //   blurRadius: 50,
          //   spreadRadius: 0.01,
          //   offset: Offset(3, 3),
          // ),
        ],
      ),
    );
  }
}
