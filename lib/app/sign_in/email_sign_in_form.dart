import 'package:flutter/material.dart';

import '../../common_widgets/form_submit_button.dart';
import '../../services/auth.dart';

enum EmailSignInFormType {
  signIn,
  register,
}

class EmailSignInForm extends StatefulWidget {
  final AuthBase auth;
  EmailSignInForm({@required this.auth});

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailController = TextEditingController();
  final _pswrdController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _pswrdFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _pswrdController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_pswrdFocusNode);
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _pswrdController.clear();
  }

  Widget _buildPasswordTextField() {
    return TextField(
      controller: _pswrdController,
      focusNode: _pswrdFocusNode,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (_) => _updateState(),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (_) => _updateState(),
    );
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';

    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    bool submitEnabled = _email.isNotEmpty && _password.isNotEmpty;

    return [
      _buildEmailTextField(),
      SizedBox(height: 8),
      _buildPasswordTextField(),
      SizedBox(height: 16),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(height: 8),
      FlatButton(
        onPressed: _toggleFormType,
        child: Text(secondaryText),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  _updateState() {
    setState(() {});
  }
}
