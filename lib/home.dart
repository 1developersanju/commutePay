import 'package:bus_proj/providers/userDataProvider.dart';
import 'package:bus_proj/sideBarPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    final uid = "${user!.uid}";
    final phoneNumber = "${user.phoneNumber}";
    final firestoreStreamProvider =
        Provider.of<FirestoreStreamProvider>(context);

    return StreamBuilder(
      stream: firestoreStreamProvider.getUserDataStream(uid, phoneNumber),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          var username = data!["userName"];
          var phone = data["phone"];
          return Scaffold(
              extendBodyBehindAppBar: true,
              body: SidebarPage(
                name: username,
              ));
        } else if (snapshot.hasError) {
          // Display error message
          return Text("Error: ${snapshot.error}");
        } else {
          // Display circular progress indicator
          return CircularProgressIndicator();
        }
      },
    );
  }
}
