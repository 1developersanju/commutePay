import 'package:bus_proj/Wallet/buyCard.dart';
import 'package:bus_proj/alert.dart/addcard.dart';
import 'package:bus_proj/alert.dart/history.dart';
import 'package:bus_proj/alert.dart/recharge.dart';
import 'package:bus_proj/alert.dart/transfer.dart';
import 'package:bus_proj/helpers/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';

import '../providers/userDataProvider.dart';

class WalletView extends StatefulWidget {
  WalletView({Key? key}) : super(key: key);

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  static const _images = [
    'assets/Travelers.png',
    'assets/Push_notifications.png',
    'assets/Delivery.png',
    'assets/Pay_online.png',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuid();
  }

  @override
  Widget build(BuildContext context) {
    final firestoreStreamProvider =
        Provider.of<FirestoreStreamProvider>(context);

    return StreamBuilder(
      stream: firestoreStreamProvider.getDataStream(
          uid, currentuser!.phoneNumber.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 25.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text("wallet id: ${currentuser!.uid}"),
                                  Text(
                                    "₹ ${data!["wallet"]["WalletBalance"]}",
                                    style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black54),
                                  ),
                                  const Text(
                                    "My Balance",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.shopping_cart,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BuySmartCardPage()));
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            slivers: [
                              ///Default
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 164,
                                  child: ScrollPageView(
                                    controller: ScrollPageController(),
                                    children: _images
                                        .map((image) => _imageView(image))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return TransferMoneyDialog(
                                  balance: data!["wallet"]["WalletBalance"],
                                  phone: currentuser!.phoneNumber.toString()    ,
                                );
                              },
                            );
                          },
                          child: Row(
                            children: const [
                              CircleAvatar(
                                child: Icon(Icons.transfer_within_a_station),
                                radius: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Transfer",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return WalletRechargeDialog(
                                  cardPurchased: data["wallet"]
                                      ["CardPurchased"],
                                  phoneNo: currentuser!.phoneNumber.toString(),
                                  balance: data!["wallet"]["WalletBalance"],
                                );
                              },
                            );
                          },
                          child: Row(
                            children: const [
                              CircleAvatar(
                                child: Icon(Icons.paypal),
                                radius: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Recharge",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: ((context) => WalletHistoryPage()))),
                          child: Row(
                            children: const [
                              CircleAvatar(
                                child: Icon(Icons.history_toggle_off),
                                radius: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "History",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddSmartCardDialog();
                              },
                            );
                          },
                          child: Row(
                            children: const [
                              CircleAvatar(
                                child: Icon(Icons.add_card),
                                radius: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Add SmartCard",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Divider(),
                        Center(
                            child: TextButton(
                          child: Text("Terms&conditions"),
                          onPressed: () {},
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Display error message
          return Text("Error: ${snapshot.error}");
        } else {
          // Display circular progress indicator
          return SizedBox();
        }
      },
    );
  }
}

Widget _imageView(String image) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(image, fit: BoxFit.cover),
    ),
  );
}
