import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final db = FirebaseFirestore.instance;
var uid = FirebaseAuth.instance.currentUser!.uid;
var currentuser = FirebaseAuth.instance.currentUser;

updateUser(user) {
  createWallet(user["phone"], false);
  db
      .collection("users")
      // .doc(uid)
      .doc(user["phone"])
      .set(user);
}

createWallet(walletNo, cardPurchased) {
  var walletData = {"WalletBalance": 0, "CardPurchased": cardPurchased};
  db
      .collection("users")
      // .doc(uid)
      .doc(walletNo)
      .update({"wallet": walletData});
}

updateWalletOnTransfer(wallet) {
  var walletData = {
    "WalletBalance": wallet["amount"],
  };
  db
      .collection("users")
      // .doc(uid)
      .doc(wallet["walletId"])
      .update({"wallet.WalletBalance": wallet["amount"]});
}

Future<void> addUserToFirestore(
  cardData,
) async {
  try {
    await db
        .collection("users")
        // .doc(uid)
        .doc(cardData['phoneNumber'])
        .collection("cardData")
        .add({
      'smartCardType': cardData['smartCardType'],
      'name': cardData['name'],
      'email': cardData['email'],
      'cardNumber': cardData['phoneNumber'],
      'paymentMethod': cardData['paymentMethod'],
      'timestamp': FieldValue.serverTimestamp(),
    });
    createWallet(cardData["phoneNumber"], true);
  } catch (e) {
    print('Error adding user data to Firestore: $e');
  }
}

Future<void> recharge(
  transferData,
) async {
  try {
    await db.collection("users").doc(transferData['phoneNumber']).update({
      "wallet.WalletBalance": transferData["amount"],
      "wallet.selectedUpiApp": transferData["upi"]
    });
  } catch (e) {
    print('Error adding user data to Firestore: $e');
  }
}

Future<void> transfer(
  transferData,
) async {
  try {
    await db
        .collection("users")
        // .doc(uid)
        .doc(transferData['recipientNumber'])
        .update({"wallet.WalletBalance": transferData["transferredAmount"]});

    print("recipientNumber ${transferData['recipientNumber']}");
    print("wallet.WalletBalance:${transferData["transferredAmount"]}");
  } catch (e) {
    print('Error adding user data to Firestore: $e');
  }
}

Future<void> history(
  historyData,
) async {
  try {
    await db
        .collection("users")
        // .doc(uid)
        .doc(historyData['recipientNumber'])
        .collection("History")
        .add({
      "title": historyData["title"],
      "subtitle": historyData["subtitle"],
      "dateTime": historyData["dateTime"],
      "type": historyData['transactionType'],
      "amount": historyData["amount"],
    });
  } catch (e) {
    print('Error adding user data to Firestore: $e');
  }
}

Future<void> Notification(
  historyData,
) async {
  try {
    await db
        .collection("users")
        .doc(uid)
        .collection(historyData['recipientNumber'])
        .doc("Notifications")
        .set({
      "title": historyData["title"],
      "subtitle": historyData["subtitle"],
      "dateTime": historyData["dateTime"],
      "type": historyData['transactionType'],
      "amount": historyData["amount"],
    });
  } catch (e) {
    print('Error adding user data to Firestore: $e');
  }
}

getuid() async {
// Replace the phone number with the one you want to search for
  final String phoneNumber = "+919976917470";

  final String collectionName = "myCollection";
  final CollectionReference<Map<String, dynamic>> collectionRef =
      FirebaseFirestore.instance.collection(phoneNumber);

// Check if collectionRef is a top-level collection
  if (collectionRef.parent == null) {
    print("$collectionName is a top-level collection");
  } else {
    print(
        "$collectionName is a subcollection of ${collectionRef.parent!.path}");
  }
}
