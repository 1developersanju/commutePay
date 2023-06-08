import 'package:bus_proj/History/history_data.dart';
import 'package:bus_proj/History/history_tile.dart';
import 'package:bus_proj/Notification/Notif_data.dart';
import 'package:bus_proj/model/History_model.dart';
import 'package:bus_proj/model/Notif_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<HistoryModel> historyList = [];

  @override
  void initState() {
    //   // ignore: todo
    // ignore: todo
    //   // TODO: implement initState
    super.initState();

    historyList = getHistoryData();
  }

  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 4,
      mainAxisSpacing: 2,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1),
      itemCount: historyList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              print(1);
            },
            child: HistoryTile(
              date: historyList[index].dateTime.toString(),
              to: historyList[index].to,
              from: historyList[index].from,
              id: "1",
              price: historyList[index].cost,
            ));
      },
    );
    ;
  }
}
