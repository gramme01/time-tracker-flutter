import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/form_submit_button.dart';
import '../../common_widgets/platform_exception_alert_dialog.dart';
import '../../services/auth.dart';
import 'email_sign_in_model.dart';
import 'validators.dart';

class EmailSignInFormStateful extends StatefulWidget
    with EmailAndPasswordValidators {
  final VoidCallback onSignedIn;

  EmailSignInFormStateful({this.onSignedIn});
  @override
  _EmailSignInFormStatefulState createState() =>
      _EmailSignInFormStatefulState();
}

class _EmailSignInFormStatefulState extends State<EmailSignInFormStateful> {
  final _emailController = TextEditingController();
  final _pswrdController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _pswrdFocusNode = FocusNode();
  bool _submitted = false;
  bool _isLoading = false;

  String get _email => _emailController.text;
  String get _password => _pswrdController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _pswrdController.dispose();
    _emailFocusNode.dispose();
    _pswrdFocusNode.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      // Navigator.of(context).pop();
      if (widget.onSignedIn != null) {
        widget.onSignedIn();
      }
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final FocusNode _newFocus = widget.emailValidator.isValid(_email)
        ? _pswrdFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(_newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
      _submitted = false;
    });
    _emailController.clear();
    _pswrdController.clear();
  }

  Widget _buildPasswordTextField() {
    bool shouldShowPswordErrorText =
        _submitted && widget.pswrdValidator.isNotValid(_password);
    return TextField(
      key: Key('password'),
      controller: _pswrdController,
      focusNode: _pswrdFocusNode,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText:
            shouldShowPswordErrorText ? widget.invalidPasswordErrorText : null,
      ),
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (_) => _updateState(),
      enabled: !_isLoading,
    );
  }

  Widget _buildEmailTextField() {
    bool shouldShowEmailErrorText =
        _submitted && widget.emailValidator.isNotValid(_email);
    return TextField(
      key: Key('email'),
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText:
            shouldShowEmailErrorText ? widget.invalidEmailErrorText : null,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (_) => _updateState(),
      enabled: !_isLoading,
    );
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';

    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.pswrdValidator.isValid(_password) &&
        !_isLoading;

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
        onPressed: _isLoading ? null : _toggleFormType,
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
