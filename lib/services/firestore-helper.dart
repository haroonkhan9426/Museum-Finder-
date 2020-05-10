import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  final dbRef = Firestore.instance;

  Future<QuerySnapshot> getMuseumData() async {
    QuerySnapshot snapshots;
    try {
      snapshots = await dbRef.collection('museums').getDocuments();
      return snapshots;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
