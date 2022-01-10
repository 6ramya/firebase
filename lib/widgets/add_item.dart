import 'package:firebase/database.dart';
import 'package:firebase/validator.dart';
import 'package:firebase/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

class AddItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  const AddItemForm(
      {Key? key,
      required this.titleFocusNode,
      required this.descriptionFocusNode})
      : super(key: key);

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _addItemFormKey,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Title',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _titleController,
                    focusNode: widget.titleFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => Validator.validateField(
                      value: value,
                    ),
                    label: 'Title',
                    hint: 'Enter your note title',
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Description',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  CustomFormField(
                      maxLines: 10,
                      isLabelEnabled: false,
                      controller: _descriptionController,
                      focusNode: widget.descriptionFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      validator: (value) =>
                          Validator.validateField(value: value),
                      label: 'Description',
                      hint: 'Enter note description')
                ],
              )),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  ))
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      widget.titleFocusNode.unfocus();
                      widget.descriptionFocusNode.unfocus();

                      if (_addItemFormKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });
                        await Database.addItem(
                            title: _titleController.text,
                            description: _descriptionController.text);

                        setState(() {
                          _isProcessing = false;
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Text(
                          'Add Item',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 2),
                        )),
                  ))
        ]));
  }
}
