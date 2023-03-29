import 'package:bus_proj/Notification/Notif_data.dart';
import 'package:bus_proj/Notification/notification_tile.dart';
import 'package:bus_proj/model/Notif_model.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notificationList = [];

  @override
  void initState() {
    //   // ignore: todo
    // ignore: todo
    //   // TODO: implement initState
    super.initState();

    notificationList = getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10, left: 10.0),
            child: Center(
              child: Container(
                // height: 200,
                child: ListView.builder(
                    itemCount: notificationList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NotificationTile(
                        message: notificationList[index].message,
                        notif_id: notificationList[index].notification_id,
                        notif_type: notificationList[index].notification_type,
                        date:  notificationList[index].date_time.toString(),
                      );
                    }),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
