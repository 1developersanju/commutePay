import 'package:bus_proj/model/History_model.dart';

List<HistoryModel> getHistoryData() {
  List<HistoryModel> cars = [];
  HistoryModel notifModel = HistoryModel(
      from: '', to: '', cost: '', dateTime: DateTime(2023, 2, 7, 5, 30));
//1
  notifModel.from = "Saravanampatti";
  notifModel.to = "Ganapathy";
  notifModel.cost = '19';
  cars.add(notifModel);
  notifModel = HistoryModel(
      from: '', to: '', cost: '', dateTime: DateTime(2023, 2, 7, 5, 30));
//1
  notifModel.from = "Saravanampatti";
  notifModel.to = "Ganapathy";
  notifModel.cost = '19';
  cars.add(notifModel);

  return cars;
}
