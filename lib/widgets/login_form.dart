import 'package:firebase/database.dart';
import 'package:firebase/pages/dashboard_screen.dart';
import 'package:firebase/validator.dart';
import 'package:firebase/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final FocusNode focusNode;
  const LoginForm({Key? key, required this.focusNode}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _controller = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _loginFormKey,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 24.0,
                    ),
                    child: Column(
                      children: [
                        CustomFormField(
                          controller: _controller,
                          focusNode: widget.focusNode,
                          keyboardType: TextInputType.text,
                          inputAction: TextInputAction.done,
                          validator: (value) => Validator.validateUserID(
                            uid: value,
                          ),
                          label: 'User ID',
                          hint: 'Enter your unique identifier',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 0, right: 0),
                      child: Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.focusNode.unfocus();

                            if (_loginFormKey.currentState!.validate()) {
                              Database.userUID = _controller.text;
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => DashboardScreen()));
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(top: 16, bottom: 16),
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    letterSpacing: 2),
                              )),
                        ),
                      ))
                ],
              ))
        ]));
  }
}
