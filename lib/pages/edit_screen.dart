import 'package:firebase/database.dart';
import 'package:firebase/widgets/edit_item_form.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String documentID;
  const EditScreen(
      {Key? key,
      required this.currentDescription,
      required this.currentTitle,
      required this.documentID})
      : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  bool _isDeleting = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _titleFocusNode.unfocus();
          _descriptionFocusNode.unfocus();
        },
        child: Scaffold(
            backgroundColor: Colors.teal[300],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.teal[200],
              title: Text('Edit note'),
              actions: [
                _isDeleting
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          right: 16.0,
                        ),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.redAccent,
                          ),
                          strokeWidth: 3,
                        ),
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                          size: 32,
                        ),
                        onPressed: () async {
                          setState(() {
                            _isDeleting = true;
                          });

                          await Database.deleteItem(
                            docID: widget.documentID,
                          );

                          setState(() {
                            _isDeleting = false;
                          });

                          Navigator.of(context).pop();
                        },
                      ),
              ],
            ),
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 20.0,
                    ),
                    child: EditItemForm(
                        documentId: widget.documentID,
                        titleFocusNode: _titleFocusNode,
                        descriptionFocusNode: _descriptionFocusNode,
                        currentTitle: widget.currentTitle,
                        currentDescription: widget.currentDescription)))));
  }
}
