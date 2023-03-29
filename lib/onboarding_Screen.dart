import 'package:bus_proj/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';

class OnBoardingView extends StatelessWidget {
  /*here we have a list of OnbordingScreen which we want to have, each OnbordingScreen have a imagePath,title and an desc.
      */
  final List<OnbordingData> list = const [
    OnbordingData(
      image: AssetImage("assets/Travelers.png"),
      titleText: Text("This is Title1"),
      descText: Text("This is desc1"),
    ),
    OnbordingData(
      image: AssetImage("assets/Push_notifications.png"),
      titleText: Text("This is Title2"),
      descText: Text("This is desc2"),
    ),
    OnbordingData(
      image: AssetImage("assets/Delivery.png"),
      titleText: Text("This is Title3"),
      descText: Text("This is desc4"),
    ),
    OnbordingData(
      image: AssetImage("assets/Pay_online.png"),
      titleText: Text("This is Title4"),
      descText: Text("This is desc4"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    /* remove the back button in the AppBar is to set automaticallyImplyLeading to false
  here we need to pass the list and the route for the next page to be opened after this. */
    return IntroScreen(
      onbordingDataList: list,
      colors: const [
        //list of colors for per pages
        Colors.white,
        Colors.red,
      ],
      pageRoute: MaterialPageRoute(
        allowSnapshotting: false,
        builder: (context) => const HomePage(),
      ),
      nextButton: const Text(
        "NEXT",
        style: TextStyle(
          color: Colors.purple,
        ),
      ),
      lastButton: const Text(
        "GOT IT",
        style: TextStyle(
          color: Colors.purple,
        ),
      ),
      skipButton: const Text(
        "SKIP",
        style: TextStyle(
          color: Colors.purple,
        ),
      ),
      selectedDotColor: Colors.orange,
      unSelectdDotColor: Colors.grey,
    );
  }
}
