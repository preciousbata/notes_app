import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseService {
  final fireStoreInstance = FirebaseFirestore.instance;

  Future<DocumentReference<Map<String, dynamic>>> saveToCollection(String collectionPath, Map<String, dynamic> data) async {
    final collection = fireStoreInstance.collection(collectionPath);
    return collection.add(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCollections(String collectionPath) {
    return fireStoreInstance.collection(collectionPath).snapshots();
  }

  Future updateCollection(String collectionPath, String referenceId, Map<String, dynamic> data) {
    return fireStoreInstance.collection(collectionPath).doc(referenceId).update(data);
  }

  Future deleteCollection(String collectionPath, String referenceId) {
    return fireStoreInstance.collection(collectionPath).doc(referenceId).delete();
  }
}
