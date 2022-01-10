import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');

class Database {
  static String? userUID;

  static Future<void> addItem(
      {required String? title, required String? description}) async {
    print(_firestore);
    print(_mainCollection);
    DocumentReference documentReference =
        _mainCollection.doc(userUID).collection('items').doc();
    Map<String, dynamic> data = <String, dynamic>{
      'title': title,
      'description': description
    };

    await documentReference
        .set(data)
        .whenComplete(() => print('note added to database'))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userUID).collection('items');

    return notesItemCollection.snapshots();
  }

  static Future<void> updateItem(
      {required String? title,
      required String? description,
      required String? docID}) async {
    DocumentReference documentReference =
        _mainCollection.doc(userUID).collection('items').doc(docID);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description
    };

    await documentReference
        .update(data)
        .whenComplete(() => print('note updated'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteItem({required String? docID}) async {
    DocumentReference documentReference =
        _mainCollection.doc(userUID).collection('items').doc(docID);

    await documentReference
        .delete()
        .whenComplete(() => print('note deleted'))
        .catchError((e) => print(e));
  }
}
