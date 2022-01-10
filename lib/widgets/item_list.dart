import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/database.dart';
import 'package:firebase/pages/edit_screen.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Database.readItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var noteInfo =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  String docID = snapshot.data!.docs[index].id;
                  String title = noteInfo["title"];
                  String description = noteInfo['description'];

                  return Ink(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditScreen(
                                currentTitle: title,
                                currentDescription: description,
                                documentID: docID),
                          ),
                        ),
                        title: Text(title,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        subtitle: Text(
                          description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ));
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16);
                });
          }
          return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.deepOrange)));
        });
  }
}
