import 'package:bus_proj/model/Notif_model.dart';

List<NotificationModel> getNotificationList() {
  List<NotificationModel> cars = [];
  NotificationModel notifModel = NotificationModel(
      message: '',
      notification_id: '',
      notification_type: '',
      date_time: DateTime(2023, 2, 7, 5, 30));
//1
  notifModel.message = "Bus is full, wait for another";
  notifModel.notification_id = "1";
  notifModel.notification_type = 'No seat available';
  cars.add(notifModel);
  //2
  notifModel = NotificationModel(
      message: '',
      notification_id: '',
      notification_type: '',
      date_time: DateTime(2023, 2, 7, 5, 30));
  notifModel.message = "Recharge successful '₹ 500'";
  notifModel.notification_id = "2";
  notifModel.notification_type = "Recharged";

  cars.add(notifModel);

  notifModel = NotificationModel(
      message: '',
      notification_id: '',
      notification_type: '',
      date_time: DateTime(2023, 2, 7, 5, 30));
  notifModel.message = "Kindly recharge 'Low balance'";
  notifModel.notification_id = "2";
  notifModel.notification_type = "Low balance";

  cars.add(notifModel);
  //3
  notifModel = NotificationModel(
      message: '',
      notification_id: '',
      notification_type: '',
      date_time: DateTime(2023, 1, 7, 5, 30));
  notifModel.message = "Boarded on bus 'TN 37 AK 9597'";
  notifModel.notification_id = "3";
  notifModel.notification_type = "boarded";

  cars.add(notifModel);
  //4
  notifModel = NotificationModel(
      message: '',
      notification_id: '',
      notification_type: '',
      date_time: DateTime(2023, 1, 7, 5, 30));
  notifModel.message = "Disembarked from bus 'TN 37 AK 9597'";
  notifModel.notification_id = "4";
  notifModel.notification_type = "disembarked";

  cars.add(notifModel);
  //5
  notifModel = NotificationModel(
      message: '',
      notification_id: '',
      notification_type: '',
      date_time: DateTime(2023, 1, 7, 5, 30));
  notifModel.message = "Bus is full, wait for another";
  notifModel.notification_id = "5";
  notifModel.notification_type = 'No seat available';

  cars.add(notifModel);
  //6
  notifModel = NotificationModel(
      message: '',
      notification_id: '',
      notification_type: '',
      date_time: DateTime(2022, 9, 7, 5, 30));
  notifModel.message = "Bus is full, wait for another";
  notifModel.notification_id = "6";
  notifModel.notification_type = 'No seat available';

  cars.add(notifModel);
  return cars;
}
