import 'package:bus_proj/Wallet/buyCard.dart';
import 'package:bus_proj/alert.dart/addcard.dart';
import 'package:bus_proj/alert.dart/history.dart';
import 'package:bus_proj/alert.dart/recharge.dart';
import 'package:bus_proj/alert.dart/transfer.dart';
import 'package:flutter/material.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';

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
  Widget build(BuildContext context) {
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
                          children: const [
                            Text(
                              "₹ 2900",
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            ),
                            Text(
                              "My Balance",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            child: IconButton(
                              icon: const Icon(
                                Icons.shopping_cart,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BuySmartCardPage()));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
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
                          return TransferMoneyDialog();
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
                                fontWeight: FontWeight.w500, fontSize: 25),
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
                          return WalletRechargeDialog();
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
                                fontWeight: FontWeight.w500, fontSize: 25),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
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
                                fontWeight: FontWeight.w500, fontSize: 25),
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
                                fontWeight: FontWeight.w500, fontSize: 25),
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
