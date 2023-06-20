import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Result {
  static saveResult() {
    // if (FirebaseAuth.instance.currentUser == null) return;

    // FirebaseAuth auth = FirebaseAuth.instance.currentUser();

    //now below I am getting an instance of firebaseiestore then getting the user collection
    //now I am creating the document if not already exist and setting the data.
    print("Saving now ... ");
    FirebaseFirestore.instance
        .collection('result')
        .add({'subject': 'Physics', 'user': 't@t.com', 'score': 75});
  }
}
