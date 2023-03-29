// ignore_for_file: prefer_const_constructors

import 'package:bus_proj/helpers/constants.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String message, notif_id, notif_type, date;
  NotificationTile({
    required this.message,
    required this.notif_id,
    required this.notif_type,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          print("tapped ");
        },
        child: Card(
            elevation: notif_type == "Low balance" ? 10 :notif_type == "Recharged"? 20: 0,
            color: blueClr,
            child: ListTile(
              leading: Icon(Icons.notifications),
              title: Text(message),
              selected: notif_type == "Low balance" || notif_type == "Recharged"
                  ? true
                  : false,
              selectedColor:notif_type == "Low balance"? Colors.red : Colors.white,
              subtitle: Text(date),
            )));
  }
}

// single book tile

