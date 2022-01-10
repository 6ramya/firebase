import 'package:firebase/widgets/add_item.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _titleFocusNode.unfocus();
          _descriptionFocusNode.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.teal[200],
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.teal[300],
            title: Text('Add Note'),
          ),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 20),
            child: AddItemForm(
                titleFocusNode: _titleFocusNode,
                descriptionFocusNode: _descriptionFocusNode),
          )),
        ));
  }
}
