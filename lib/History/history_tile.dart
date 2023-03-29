import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryTile extends StatefulWidget {
  String to;
  String price;
  String from;
  String date;
  String id;
  HistoryTile(
      {Key? key,
      required this.to,
      required this.date,
      required this.from,
      required this.price,
      required this.id})
      : super(key: key);

  @override
  State<HistoryTile> createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
            width: width * 0.5,
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.26,
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.24,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3)),
                              child: const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: GoogleMap(
                                        zoomControlsEnabled: false,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(20.5937, 78.9629),
                                        ))),
                              )),
                          Text(
                            '${DateTime.parse(widget.date).year}-${DateTime.parse(widget.date).month}-${DateTime.parse(widget.date).day}',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: width * 0.33,
                          child: Text(
                            "${widget.from} - ${widget.to}",
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('₹ ${widget.price}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
